import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository{
  @override
  Future<Either<Failure, NumberTrivia>>? getConcreteNumberTrivia(int? number) {
    
    
  }

  @override
  Future<Either<Failure, NumberTrivia>>? getRandomNumberTrivia() {
    
  }

}