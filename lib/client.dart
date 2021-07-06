import 'package:grpc/grpc.dart';

import 'generated/cheterz.pbgrpc.dart';

class CheterzTerminalClient {
  late final ClientChannel channel;
  late final cheterzClient stub;

  CheterzTerminalClient() {
    channel = ClientChannel(
      '127.0.0.1',
      port: 5555,
      options: ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    stub = cheterzClient(channel);
  }

  Future<Question> getQuestion(Student student) async {
    final question = await stub.getQuestion(student);
    print('Received question: $question');
    return question;
  }

  Future<void> callService(Student student) async {
    await getQuestion(student);
    await channel.shutdown();
  }
}

Future<void> main(List<String> args) async {
  final clientApp = CheterzTerminalClient();
  final student = Student()
    ..id = 42
    ..name = 'Alice Bobich';
  await clientApp.callService(student);
}
