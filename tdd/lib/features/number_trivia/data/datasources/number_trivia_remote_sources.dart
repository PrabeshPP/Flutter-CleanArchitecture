import 'package:tdd/features/number_trivia/data/models/number_trivia_model.dart';



abstract class NumberTriviaRemoteSources {
  Future<NumberTriviaModel>? getConcreteNumberTrivia(int? number);
  Future<NumberTriviaModel>? getRandomNumberTrivia();
}

class NumberTriviaRemoteSourcesImpl implements NumberTriviaRemoteSources{
  @override
  Future<NumberTriviaModel>? getConcreteNumberTrivia(int? number) {
   
    throw UnimplementedError();
  }

  @override
  Future<NumberTriviaModel>? getRandomNumberTrivia() {
  
    throw UnimplementedError();
  }

}
