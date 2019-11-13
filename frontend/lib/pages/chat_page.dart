
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/chat_bloc.dart';
import 'package:frontend/widgets/chatroom_messages_widget.dart';
import 'package:frontend/widgets/send_chat_widget.dart';


class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChatState();
}

class ChatState extends State<ChatPage> {

  ChatBloc _chatBloc;
  @override
  void initState() {
    super.initState();
    _chatBloc = BlocProvider.of<ChatBloc>(context);
    _chatBloc.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ChatRoomMessagesWidget()
          ),
          SendChatWidget()
        ],
      )
    );
  }

  @override
  void dispose() {
    _chatBloc.leave();
    super.dispose();
  }
}