import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel>? getLastNumberTrivia();
  Future<void>? cacheNumberTrivia(NumberTriviaModel? numberTriviaModel);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void>? cacheNumberTrivia(NumberTriviaModel? numberTriviaModel) {
  

  }

  @override
  Future<NumberTriviaModel>? getLastNumberTrivia() {

  }
}
