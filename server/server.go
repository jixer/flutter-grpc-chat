package main

import (
	"fmt"
	"io"
	"net"
	"sync"

	"github.com/google/uuid"
	"github.com/jixer/flutter-grpc-chat/server/chat"
	"golang.org/x/net/context"

	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type server struct {
	Host string

	Broadcast chan chat.ChatMessage

	Clients              map[string]chan chat.ChatMessage
	namesMtx, streamsMtx sync.RWMutex
}

func Server(host string) *server {
	return &server{
		Host: host,

		Broadcast: make(chan chat.ChatMessage, 1000),

		Clients: make(map[string]chan chat.ChatMessage),
	}
}

func (s *server) Run(ctx context.Context) error {
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()

	ServerLogf("Starting listener on %s", s.Host)
	srv := grpc.NewServer()
	chat.RegisterChatServiceServer(srv, s)

	l, err := net.Listen("tcp", s.Host)
	if err != nil {
		return fmt.Errorf("Error occurred starting TCP listener: %s", err)
	}

	go s.broadcast(ctx)

	go func() {
		srv.Serve(l)
		cancel()
	}()

	<-ctx.Done()

	close(s.Broadcast)
	ServerLogf("shutting down")
	srv.GracefulStop()
	return nil
}

func (s *server) StreamChat(srv chat.ChatService_StreamChatServer) error {
	id, err := uuid.NewUUID()
	if err != nil {
		return status.Errorf(codes.Unknown, "Could not generate a unique identifier for this session: %s", err)
	}

	go s.sendBroadcasts(srv, id.String())

	for {
		req, err := srv.Recv()
		if err == io.EOF {
			break
		} else if err != nil {
			return err
		}

		s.Broadcast <- *req
	}

	<-srv.Context().Done()
	return srv.Context().Err()
}

func (s *server) broadcast(ctx context.Context) {
	for res := range s.Broadcast {
		s.streamsMtx.RLock()
		for _, stream := range s.Clients {
			select {
			case stream <- res:
				// noop
			default:
				ServerLogf("client stream full, dropping message")
			}
		}
		s.streamsMtx.RUnlock()
	}
}

func (s *server) sendBroadcasts(srv chat.ChatService_StreamChatServer, id string) {
	stream := s.openStream(id)
	defer s.closeStream(id)

	for {
		select {
		case <-srv.Context().Done():
			return
		case res := <-stream:
			if s, ok := status.FromError(srv.Send(&res)); ok {
				switch s.Code() {
				case codes.OK:
					// noop
				case codes.Unavailable, codes.Canceled, codes.DeadlineExceeded:
					ServerLogf("client (%s) terminated connection", id)
					return

				default:
					ServerLogf("Failed to send data to client (%s): %v", id, s.Err())
				}
			}
		}
	}
}

func (s *server) openStream(id string) (stream chan chat.ChatMessage) {
	stream = make(chan chat.ChatMessage, 100)

	s.streamsMtx.Lock()
	s.Clients[id] = stream
	s.streamsMtx.Unlock()

	ServerLogf("opened stream for client %s", id)

	return
}

func (s *server) closeStream(id string) {
	s.streamsMtx.Lock()

	if stream, ok := s.Clients[id]; ok {
		delete(s.Clients, id)
		close(stream)
	}

	ServerLogf("closed stream for client %s", id)

	s.streamsMtx.Unlock()
}
