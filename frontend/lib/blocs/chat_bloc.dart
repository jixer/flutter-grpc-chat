import 'package:frontend/events/chat_event.dart';
import 'package:frontend/protos/chat.pbgrpc.dart';
import 'package:frontend/services/chat_service.dart';
import 'package:frontend/services/service_locator.dart';
import 'package:frontend/states/chat_state.dart';
import 'base_bloc.dart';

class ChatBloc extends BaseBloc<ChatEvent, ChatState> {
  Stream<ChatMessage> _strm;

  @override
  ChatState get initialState {
    return ChatRoomLoaded(roomJoined: true);
  }

  @override
  Stream<ChatState> mapEventToState(ChatState currentState, ChatEvent event) async*{
    switch (event.action) {
      case ChatEnum.MessageRecieved:
        List<ChatMessage> messages = currentState is ChatRoomActive 
                                      ? currentState.messages
                                      : List<ChatMessage>();

        messages.add(event.chat);
        yield ChatRoomActive(messages: messages);
        break; 
    }
  }

  void send({String message}) async {
    await sl.get<ChatService>().send(message);
  }

  void leave() async {
    await sl.get<ChatService>().leave();
    _strm = null;
  }

  void initialize() {
    if (_strm == null) {
      _strm = sl.get<ChatService>().subscribe();
      _strm.listen(onData);
    }
  }

  void onData(ChatMessage event) {
    dispatch(ChatEvent(action: ChatEnum.MessageRecieved, chat: event));
  }
}