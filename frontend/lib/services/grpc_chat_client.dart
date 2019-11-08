import 'package:grpc/grpc.dart';

class GrpcChatClientSingleton {
  ClientChannel client;
  static final GrpcChatClientSingleton _singleton = new GrpcChatClientSingleton._internal();

  factory GrpcChatClientSingleton() => _singleton;

  GrpcChatClientSingleton._internal() {
    client = ClientChannel("", // Your IP here, localhost might not work.
        port: 3000,
        options: ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          idleTimeout: Duration(minutes: 15),
        ));
  }
}