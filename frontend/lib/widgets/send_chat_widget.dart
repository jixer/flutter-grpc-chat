import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/chat_bloc.dart';
import 'package:frontend/events/chat_event.dart';
import 'package:frontend/states/chat_state.dart';

class SendChatWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SendChatState();
}

class SendChatState extends State<SendChatWidget> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController msgCntrlr = TextEditingController();
    final ChatBloc chatBloc = BlocProvider.of<ChatBloc>(context);
    return BlocBuilder<ChatEvent, ChatState>(
      bloc: chatBloc,
      builder: (context, state) {
        return Row(children: [
          Expanded(
            child: TextField(
              controller: msgCntrlr,
              decoration: InputDecoration(
                hintText: 'Enter chat message'
              ),
            ),
          ),
          RaisedButton(
            child: const Text('Send'),
            onPressed: () => chatBloc.send(message: msgCntrlr.text),
          )
        ]);
      },
    );
  }
}