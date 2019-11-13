import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/home_bloc.dart';
import 'package:frontend/pages/chat_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/services/service_locator.dart';

import 'blocs/chat_bloc.dart';

void main() {
  setupIoC();
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  final HomeBloc _homeBloc = HomeBloc();
  final ChatBloc _chatBloc = ChatBloc();
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'gRPC Chat',
      initialRoute: '/',
      routes: createRoutes(),
    );
  }

  createRoutes() {
    return {
      '/': (context) => BlocProvider<HomeBloc>(bloc: _homeBloc, child: HomePage()),
      '/chat': (context) => BlocProvider<ChatBloc>(bloc: _chatBloc, child: ChatPage())
    };
  }

  @override
  void dispose() {
    _chatBloc.dispose();
    _homeBloc.dispose();
    super.dispose();
  }
}



class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
    super.onError(error, stacktrace);
  }
} 