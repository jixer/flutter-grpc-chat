
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/chat_bloc.dart';
import 'package:frontend/events/chat_event.dart';
import 'package:frontend/protos/chat.pb.dart';
import 'package:frontend/states/chat_state.dart';

class ChatPage extends StatelessWidget {
  // @override
  // State<StatefulWidget> createState() => ChatPageState();

  @override
  Widget build(BuildContext context) {
    final ChatBloc _chatBloc = BlocProvider.of<ChatBloc>(context);
    final TextEditingController _msgController = TextEditingController();

    return BlocBuilder<ChatEvent, ChatState>(
      bloc: _chatBloc,
      builder: (context, snapshot) {
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
      },
    );
  }
}

class ChatRoomMessagesWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChatRoomMessagesState();

}

class ChatRoomMessagesState extends State<ChatRoomMessagesWidget> {
  final _scrollController = ScrollController();
  //final _scrollThreshold = 200.0;
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
      title: Text(msg.message),
    );
  }
  
}

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