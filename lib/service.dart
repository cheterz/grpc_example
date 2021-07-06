import 'dart:math';

import 'package:cheterz/generated/cheterz.pbgrpc.dart';
import 'package:cheterz/questions_db_driver.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:grpc/service_api.dart';

class CheterzService extends cheterzServiceBase {
  @override
  Future<Question> getQuestion(ServiceCall call, Student request) async {
    print('Received question request from: $request');
    return questionsDb[Random().nextInt(questionsDb.length)];
  }

  @override
  Future<Evaluation> sendAnswer(ServiceCall call, Answer request) {
    // TODO: implement sendAnswer
    throw UnimplementedError();
  }
}

class Server {
  Future<void> run() async {
    final server = grpc.Server([CheterzService()]);
    await server.serve(port: 5555);
    print('Serving on the port: ${server.port}');
  }
}

Future<void> main() async {
  await Server().run();
}
