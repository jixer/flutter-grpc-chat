// Code generated by protoc-gen-go. DO NOT EDIT.
// source: chat.proto

package chat

import (
	context "context"
	fmt "fmt"
	proto "github.com/golang/protobuf/proto"
	timestamp "github.com/golang/protobuf/ptypes/timestamp"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
	math "math"
)

// Reference imports to suppress errors if they are not otherwise used.
var _ = proto.Marshal
var _ = fmt.Errorf
var _ = math.Inf

// This is a compile-time assertion to ensure that this generated file
// is compatible with the proto package it is being compiled against.
// A compilation error at this line likely means your copy of the
// proto package needs to be updated.
const _ = proto.ProtoPackageIsVersion3 // please upgrade the proto package

type ChatMessage struct {
	Timestamp            *timestamp.Timestamp `protobuf:"bytes,1,opt,name=timestamp,proto3" json:"timestamp,omitempty"`
	Alias                string               `protobuf:"bytes,2,opt,name=alias,proto3" json:"alias,omitempty"`
	Message              string               `protobuf:"bytes,3,opt,name=message,proto3" json:"message,omitempty"`
	XXX_NoUnkeyedLiteral struct{}             `json:"-"`
	XXX_unrecognized     []byte               `json:"-"`
	XXX_sizecache        int32                `json:"-"`
}

func (m *ChatMessage) Reset()         { *m = ChatMessage{} }
func (m *ChatMessage) String() string { return proto.CompactTextString(m) }
func (*ChatMessage) ProtoMessage()    {}
func (*ChatMessage) Descriptor() ([]byte, []int) {
	return fileDescriptor_8c585a45e2093e54, []int{0}
}

func (m *ChatMessage) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_ChatMessage.Unmarshal(m, b)
}
func (m *ChatMessage) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_ChatMessage.Marshal(b, m, deterministic)
}
func (m *ChatMessage) XXX_Merge(src proto.Message) {
	xxx_messageInfo_ChatMessage.Merge(m, src)
}
func (m *ChatMessage) XXX_Size() int {
	return xxx_messageInfo_ChatMessage.Size(m)
}
func (m *ChatMessage) XXX_DiscardUnknown() {
	xxx_messageInfo_ChatMessage.DiscardUnknown(m)
}

var xxx_messageInfo_ChatMessage proto.InternalMessageInfo

func (m *ChatMessage) GetTimestamp() *timestamp.Timestamp {
	if m != nil {
		return m.Timestamp
	}
	return nil
}

func (m *ChatMessage) GetAlias() string {
	if m != nil {
		return m.Alias
	}
	return ""
}

func (m *ChatMessage) GetMessage() string {
	if m != nil {
		return m.Message
	}
	return ""
}

func init() {
	proto.RegisterType((*ChatMessage)(nil), "chat.ChatMessage")
}

func init() { proto.RegisterFile("chat.proto", fileDescriptor_8c585a45e2093e54) }

var fileDescriptor_8c585a45e2093e54 = []byte{
	// 181 bytes of a gzipped FileDescriptorProto
	0x1f, 0x8b, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xff, 0xe2, 0xe2, 0x4a, 0xce, 0x48, 0x2c,
	0xd1, 0x2b, 0x28, 0xca, 0x2f, 0xc9, 0x17, 0x62, 0x01, 0xb1, 0xa5, 0xe4, 0xd3, 0xf3, 0xf3, 0xd3,
	0x73, 0x52, 0xf5, 0xc1, 0x62, 0x49, 0xa5, 0x69, 0xfa, 0x25, 0x99, 0xb9, 0xa9, 0xc5, 0x25, 0x89,
	0xb9, 0x05, 0x10, 0x65, 0x4a, 0xe5, 0x5c, 0xdc, 0xce, 0x19, 0x89, 0x25, 0xbe, 0xa9, 0xc5, 0xc5,
	0x89, 0xe9, 0xa9, 0x42, 0x16, 0x5c, 0x9c, 0x70, 0x15, 0x12, 0x8c, 0x0a, 0x8c, 0x1a, 0xdc, 0x46,
	0x52, 0x7a, 0x10, 0x33, 0xf4, 0x60, 0x66, 0xe8, 0x85, 0xc0, 0x54, 0x04, 0x21, 0x14, 0x0b, 0x89,
	0x70, 0xb1, 0x26, 0xe6, 0x64, 0x26, 0x16, 0x4b, 0x30, 0x29, 0x30, 0x6a, 0x70, 0x06, 0x41, 0x38,
	0x42, 0x12, 0x5c, 0xec, 0xb9, 0x10, 0xa3, 0x25, 0x98, 0xc1, 0xe2, 0x30, 0xae, 0x91, 0x3b, 0xc4,
	0xe2, 0xe0, 0xd4, 0xa2, 0xb2, 0xcc, 0x64, 0x90, 0xc5, 0x5c, 0xc1, 0x25, 0x45, 0xa9, 0x89, 0xb9,
	0x20, 0x41, 0x21, 0x41, 0x3d, 0xb0, 0x4f, 0x90, 0x5c, 0x26, 0x85, 0x29, 0xa4, 0xc4, 0xa0, 0xc1,
	0x68, 0xc0, 0x98, 0xc4, 0x06, 0x76, 0x97, 0x31, 0x20, 0x00, 0x00, 0xff, 0xff, 0xa5, 0x69, 0x72,
	0x7d, 0xfd, 0x00, 0x00, 0x00,
}

// Reference imports to suppress errors if they are not otherwise used.
var _ context.Context
var _ grpc.ClientConn

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
const _ = grpc.SupportPackageIsVersion4

// ChatServiceClient is the client API for ChatService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
type ChatServiceClient interface {
	StreamChat(ctx context.Context, opts ...grpc.CallOption) (ChatService_StreamChatClient, error)
}

type chatServiceClient struct {
	cc *grpc.ClientConn
}

func NewChatServiceClient(cc *grpc.ClientConn) ChatServiceClient {
	return &chatServiceClient{cc}
}

func (c *chatServiceClient) StreamChat(ctx context.Context, opts ...grpc.CallOption) (ChatService_StreamChatClient, error) {
	stream, err := c.cc.NewStream(ctx, &_ChatService_serviceDesc.Streams[0], "/chat.ChatService/StreamChat", opts...)
	if err != nil {
		return nil, err
	}
	x := &chatServiceStreamChatClient{stream}
	return x, nil
}

type ChatService_StreamChatClient interface {
	Send(*ChatMessage) error
	Recv() (*ChatMessage, error)
	grpc.ClientStream
}

type chatServiceStreamChatClient struct {
	grpc.ClientStream
}

func (x *chatServiceStreamChatClient) Send(m *ChatMessage) error {
	return x.ClientStream.SendMsg(m)
}

func (x *chatServiceStreamChatClient) Recv() (*ChatMessage, error) {
	m := new(ChatMessage)
	if err := x.ClientStream.RecvMsg(m); err != nil {
		return nil, err
	}
	return m, nil
}

// ChatServiceServer is the server API for ChatService service.
type ChatServiceServer interface {
	StreamChat(ChatService_StreamChatServer) error
}

// UnimplementedChatServiceServer can be embedded to have forward compatible implementations.
type UnimplementedChatServiceServer struct {
}

func (*UnimplementedChatServiceServer) StreamChat(srv ChatService_StreamChatServer) error {
	return status.Errorf(codes.Unimplemented, "method StreamChat not implemented")
}

func RegisterChatServiceServer(s *grpc.Server, srv ChatServiceServer) {
	s.RegisterService(&_ChatService_serviceDesc, srv)
}

func _ChatService_StreamChat_Handler(srv interface{}, stream grpc.ServerStream) error {
	return srv.(ChatServiceServer).StreamChat(&chatServiceStreamChatServer{stream})
}

type ChatService_StreamChatServer interface {
	Send(*ChatMessage) error
	Recv() (*ChatMessage, error)
	grpc.ServerStream
}

type chatServiceStreamChatServer struct {
	grpc.ServerStream
}

func (x *chatServiceStreamChatServer) Send(m *ChatMessage) error {
	return x.ServerStream.SendMsg(m)
}

func (x *chatServiceStreamChatServer) Recv() (*ChatMessage, error) {
	m := new(ChatMessage)
	if err := x.ServerStream.RecvMsg(m); err != nil {
		return nil, err
	}
	return m, nil
}

var _ChatService_serviceDesc = grpc.ServiceDesc{
	ServiceName: "chat.ChatService",
	HandlerType: (*ChatServiceServer)(nil),
	Methods:     []grpc.MethodDesc{},
	Streams: []grpc.StreamDesc{
		{
			StreamName:    "StreamChat",
			Handler:       _ChatService_StreamChat_Handler,
			ServerStreams: true,
			ClientStreams: true,
		},
	},
	Metadata: "chat.proto",
}
