import 'package:frontend/services/chat_service.dart';
import 'package:frontend/services/chat_service_impl.dart';
//import 'package:frontend/services/mock_chat_service_impl.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = new GetIt();

void setupIoC() {
  sl.registerLazySingleton<ChatService>(() => ChatServiceImpl());
}