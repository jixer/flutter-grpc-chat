
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/chat_bloc.dart';
import 'package:frontend/widgets/chatroom_messages_widget.dart';
import 'package:frontend/widgets/send_chat_widget.dart';

class ChatPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context).initialize();
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
}