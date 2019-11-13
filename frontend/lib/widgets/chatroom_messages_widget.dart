import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/chat_bloc.dart';
import 'package:frontend/events/chat_event.dart';
import 'package:frontend/protos/chat.pb.dart';
import 'package:frontend/states/chat_state.dart';
import 'package:intl/intl.dart';

class ChatRoomMessagesWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChatRoomMessagesState();

}

class ChatRoomMessagesState extends State<ChatRoomMessagesWidget> {
  final _scrollController = ScrollController();
  ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _chatBloc = BlocProvider.of<ChatBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<ChatEvent, ChatState>(
      bloc: _chatBloc,
      builder: (context, snapshot) {
        if (snapshot is ChatRoomLoaded) {
          String txt = snapshot.roomJoined
                          ? "Joom joined.  Send a message"
                          : "Failed to join chatroom";
          
          return Center(child: Text(txt));
        }
        
        if (snapshot is ChatRoomActive) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ChatMessageWidget(msg: snapshot.messages[index]);
            },
            itemCount: snapshot.messages.length,
            controller: _scrollController,
          );
        }

        return Center(child: Text('Unknown error occurred'));
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    
  }
}

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage msg;

  ChatMessageWidget({Key key, @required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: RichText(text: TextSpan(
        text: msg.alias,
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold
        ),
        children: <TextSpan>[
          TextSpan(
            text:  '\n' + DateFormat("h:m a").format(msg.timestamp.toDateTime().toLocal()),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal
            ),
          )
        ]
      )),
      title: RichText(text: TextSpan(
        text: msg.message,
        style: TextStyle(color: Colors.black)
      ))
    );
  } 
}