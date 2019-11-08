import 'dart:async';

import 'package:frontend/protos/chat.pb.dart';
import 'package:frontend/protos/google/protobuf/timestamp.pbserver.dart';
import 'package:frontend/services/chat_service.dart';

class MockChatServiceImpl extends ChatService {
  StreamController<ChatMessage> _ctrl;
  String _username;

  @override
  Future<bool> join({String username}) {
    _ctrl = StreamController();
    _username = username;
    return Future.value(true);

  }

  @override
  Future<bool> leave() {
    return Future.value(true);
  }

  @override
  Future<bool> send(String message) {
    return Future<bool>.delayed(Duration(seconds: 1), () {
      if (_ctrl != null) {
        var chatMsg = ChatMessage();
        chatMsg.alias = _username;
        chatMsg.timestamp = Timestamp.fromDateTime(DateTime.now());
        chatMsg.message = message;

        _ctrl.add(chatMsg);
        
        return true;
      } else 
        return false;
    });
  }

  @override
  Stream<ChatMessage> subscribe() {
    
    return _ctrl.stream;
  }

}