import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/home_bloc.dart';
import 'package:frontend/events/home_event.dart';
import 'package:frontend/states/home_state.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();

}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    var homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.state.listen(_onStateChange);
  }

  void _onStateChange(HomeState state) {
    print(state.isValidUsername);
    if (state.isValidUsername != null && state.isValidUsername == true) {
      Navigator.pushNamed(context, '/chat');
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);
    final TextEditingController _username = TextEditingController();

    return BlocBuilder<HomeEvent, HomeState>(
      bloc: _homeBloc,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _username,
                      decoration: InputDecoration(
                        hintText: 'Enter username'
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: const Text('Join Room'),
                    onPressed: () => _homeBloc.joinRoom(username: _username.text),
                  )
                ],
              )
          )
        );
      },
    );
  }
}