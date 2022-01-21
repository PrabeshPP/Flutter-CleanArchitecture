import 'dart:io';

import 'package:tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteSources {
  Future<NumberTriviaModel>? getConcreteNumberTrivia(int? number);
  Future<NumberTriviaModel>? getRandomNumberTrivia();
}

class NumberTriviaRemoteSourcesImpl implements NumberTriviaRemoteSources {
  final http.Client httpClient;

  NumberTriviaRemoteSourcesImpl({required this.httpClient});
  @override
  Future<NumberTriviaModel>? getConcreteNumberTrivia(int? number) {
    throw UnimplementedError();
  }

  @override
  Future<NumberTriviaModel>? getRandomNumberTrivia() {
    throw UnimplementedError();
  }
}
