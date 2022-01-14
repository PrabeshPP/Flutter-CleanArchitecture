import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRemoteSources {
  Future<NumberTrivia> getConcreteNumberTrivia(int number);
  Future<NumberTrivia> getRandomNumberTrivia();
}
