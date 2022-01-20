import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd/core/error/exception.dart';
import 'package:tdd/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel>? getLastNumberTrivia();
  Future<void>? cacheNumberTrivia(NumberTriviaModel? numberTriviaModel);
}

const CACHED_NUMBER_TRIVIA = "CACHED_NUMBER_TRIVIA";

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel? numberTriviaModel) async{
    await sharedPreferences.setString(
        CACHED_NUMBER_TRIVIA, jsonEncode(numberTriviaModel!.toJSon()));
  }

  @override
  Future<NumberTriviaModel>? getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
