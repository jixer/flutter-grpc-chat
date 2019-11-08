import 'package:frontend/events/home_event.dart';
import 'package:frontend/services/chat_service.dart';
import 'package:frontend/services/service_locator.dart';
import 'package:frontend/states/home_state.dart';
import 'base_bloc.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeState();

  @override
  Stream<HomeState> mapEventToState(HomeState currentState, HomeEvent event) async* {
    if (event.action == HomeEnum.JoinRoom) {
      yield await joinChatRoom(event.username);
    }
  }

  void joinRoom({String username}) {
    dispatch(HomeEvent(action: HomeEnum.JoinRoom, username: username));
  }

  Future<HomeState> joinChatRoom(String username) async {
    await sl.get<ChatService>().join(username: username);
    return HomeState(isValidUsername: true);
  }
} 