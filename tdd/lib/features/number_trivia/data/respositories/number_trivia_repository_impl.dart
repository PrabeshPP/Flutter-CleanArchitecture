import 'package:tdd/core/platform/network_info.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_remote_sources.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaLocalDataSource numberTriviaLocalDataSource;
  final NumberTriviaRemoteSources numberTriviaRemoteSources;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {required this.numberTriviaLocalDataSource,
      required this.numberTriviaRemoteSources,
      required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>>? getConcreteNumberTrivia(int? number) {}

  @override
  Future<Either<Failure, NumberTrivia>>? getRandomNumberTrivia() {}
}
