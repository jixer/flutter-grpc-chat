import 'package:bloc/bloc.dart';

class BaseBloc<Event, State> extends Bloc<Event,State>{
  @override
  State get initialState => null;

  @override
  Stream<State> mapEventToState(State currentState, Event event) {
    return null;
  }
  
  void handleRoute(String name, Object arguments){ }
}