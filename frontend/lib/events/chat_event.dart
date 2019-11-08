import 'package:frontend/protos/chat.pb.dart';

enum ChatEnum {MessageRecieved}

class ChatEvent {
  final ChatEnum action;
  final ChatMessage chat;

  ChatEvent({this.action, this.chat});
}