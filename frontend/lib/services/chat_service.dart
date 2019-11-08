import 'dart:async';

import 'package:frontend/protos/chat.pbgrpc.dart';
import 'package:frontend/services/base_service.dart';

abstract class ChatService implements BaseService {
  Future<bool> join({String username});
  Stream<ChatMessage> subscribe();
  Future<bool> send(String message);
  Future<bool> leave();
}