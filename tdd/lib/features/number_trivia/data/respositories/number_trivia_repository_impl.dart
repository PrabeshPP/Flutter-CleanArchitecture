import 'package:tdd/core/error/exception.dart';
import 'package:tdd/core/platform/network_info.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_remote_sources.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaLocalDataSource localDataSource;
  final NumberTriviaRemoteSources remoteSources;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {required this.localDataSource,
      required this.remoteSources,
      required this.networkInfo});

  @override
  Future<Either<Failure?, NumberTrivia?>?> getConcreteNumberTrivia(
      int? number) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteTrivia =
            await remoteSources.getConcreteNumberTrivia(number);
        localDataSource.cacheNumberTrivia(remoteTrivia!);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {


      try {
        final lastNUmberTrivia = await localDataSource.getLastNumberTrivia();
        return Right(lastNUmberTrivia);
      } on CacheException {
        
        return Left(CacheFailure());
      }
    }
    ;
  }

  @override
  Future<Either<Failure?, NumberTrivia?>> getRandomNumberTrivia() async {
    return Right(await remoteSources.getRandomNumberTrivia());
  }
}
