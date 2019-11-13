import 'package:grpc/grpc.dart';

class GrpcChatClientSingleton {
  ClientChannel client;
  static final GrpcChatClientSingleton _singleton = new GrpcChatClientSingleton._internal();

  factory GrpcChatClientSingleton() => _singleton;

  GrpcChatClientSingleton._internal() {
    client = ClientChannel("10.235.31.22", // Your IP here, localhost might not work.
        port: 50001,
        options: ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          idleTimeout: Duration(minutes: 15),
        ));
  }
}