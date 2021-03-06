import 'dart:convert';

import 'package:tdd/core/error/exception.dart';
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
  Future<NumberTriviaModel>? getConcreteNumberTrivia(int? number) async {
    String url = "numberapi.com";
    final locationRequest = Uri.http(url, "/$number");
    final response = await httpClient
        .get(locationRequest, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      NumberTriviaModel numberTriviaModel =
          NumberTriviaModel.fromJson(jsonData);
      return numberTriviaModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel>? getRandomNumberTrivia() async {
    String url = "numberapi.com";
    final locationRequest = Uri.http(url, "/random");
    final response = await httpClient
        .get(locationRequest, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      NumberTriviaModel numberTriviaModel =
          NumberTriviaModel.fromJson(jsonData);
      return numberTriviaModel;
    } else {
      throw ServerException();
    }
  }
}
