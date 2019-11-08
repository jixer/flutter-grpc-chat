import 'dart:async';

import 'package:frontend/protos/chat.pbgrpc.dart';
import 'package:frontend/protos/google/protobuf/timestamp.pb.dart';
import 'package:frontend/services/chat_service.dart';

import 'grpc_chat_client.dart';

class ChatServiceImpl implements ChatService {
  ChatServiceClient client;
  StreamController<ChatMessage> outboundController;
  Stream<ChatMessage> inboundStream;
  String username;

  Future<bool> join({String username}) {
    client = ChatServiceClient(GrpcChatClientSingleton().client);
    
    outboundController = StreamController<ChatMessage>();
    inboundStream = client.streamChat(outboundController.stream);

    return Future.value(true);
  }

  Stream<ChatMessage> subscribe() {
    return inboundStream;
  }

  Future<bool> send(String message) {
    var msg = ChatMessage();
    msg.message = message;
    msg.timestamp = Timestamp.fromDateTime(DateTime.now());

    outboundController.add(msg);

    return Future.value(true);
  }

  Future<bool> leave() {
    outboundController.close();
    GrpcChatClientSingleton().client.shutdown();

    return Future.value(true);
  }
}