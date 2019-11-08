enum HomeEnum {JoinRoom}

class HomeEvent {
  final HomeEnum action;
  final String username;

  HomeEvent({this.action, this.username});
}