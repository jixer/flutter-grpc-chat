import 'package:frontend/protos/chat.pb.dart';

abstract class ChatState { }

class ChatRoomLoaded extends ChatState {
  bool roomJoined;

  ChatRoomLoaded({this.roomJoined});
}

class ChatRoomActive extends ChatState {
  List<ChatMessage> messages;

  ChatRoomActive({this.messages});
}