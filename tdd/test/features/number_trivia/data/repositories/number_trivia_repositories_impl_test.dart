// ignore_for_file: prefer_const_declarations
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/error/exception.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:tdd/core/platform/network_info.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_remote_sources.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd/features/number_trivia/data/respositories/number_trivia_repository_impl.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';

class Mocktriviaremotedatasource extends Mock
    implements NumberTriviaRemoteSources {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl? repositoryImpl;
  Mocktriviaremotedatasource? mocktriviaremotedatasource;
  MockLocalDataSource? mockLocalDataSource;
  MockNetworkInfo? mockNetworkInfo;

  setUp(() {
    mocktriviaremotedatasource = Mocktriviaremotedatasource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = NumberTriviaRepositoryImpl(
        remoteSources: mocktriviaremotedatasource!,
        localDataSource: mockLocalDataSource!,
        networkInfo: mockNetworkInfo!);
  });

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel(number: tNumber, text: "test trivia");
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test("should check if the device is online", () async {
      when(mockNetworkInfo!.isConnected).thenAnswer((_) async => true);
      await repositoryImpl!.getConcreteNumberTrivia(20);
      verify(mockNetworkInfo!.isConnected);
     
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo!.isConnected).thenAnswer((_) async => true);
      });
      test('should return data when remote data source is called', () async {
        when(mocktriviaremotedatasource?.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repositoryImpl?.getConcreteNumberTrivia(tNumber);
        verify(mocktriviaremotedatasource!.getConcreteNumberTrivia(tNumber));
        expect(result, Right(tNumberTrivia));
      });
      test(
          'should cached the data locally when the call to remote data source is successful',
          () async {
        when(mocktriviaremotedatasource?.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        await repositoryImpl?.getConcreteNumberTrivia(tNumber);
        verify(mocktriviaremotedatasource!.getConcreteNumberTrivia(tNumber));
        verify(mockLocalDataSource!.cacheNumberTrivia(tNumberTriviaModel));
      });

      test(
          'should return server failure when remote data source is unsuccessful',
          () async {
        when(mocktriviaremotedatasource?.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());

        final result = await repositoryImpl?.getConcreteNumberTrivia(tNumber);
        verify(mocktriviaremotedatasource!.getConcreteNumberTrivia(tNumber));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, Left(ServerFailure()));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo!.isConnected).thenAnswer((_) async => false);
      });
      test(
          'should return the last locally cahed data when the cached data is present',
          () async {
        // arrange
        when(mockLocalDataSource!.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repositoryImpl!.getConcreteNumberTrivia(tNumber);

        //assert
        verifyZeroInteractions(mocktriviaremotedatasource);
        verify(mockLocalDataSource!.getLastNumberTrivia());
        expect(result, right(tNumberTrivia));
      });

      test('should return cache failure when there is no cahed data available',
          () async {
        // arrange
        when(mockLocalDataSource!.getLastNumberTrivia())
            .thenThrow(CacheException());
        //act
        final result = await repositoryImpl!.getConcreteNumberTrivia(tNumber);

        //assert
        verify(mockLocalDataSource!.getLastNumberTrivia());
        verifyZeroInteractions(mocktriviaremotedatasource);
        expect(result, Left(CacheFailure()));
      });
    });
  });

// getRandomNumber Trivia

//getRandomNumber Trivia
  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel(number: 47, text: "test trivia");
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test("should check if the device is online", () async {
      when(mockNetworkInfo!.isConnected).thenAnswer((_) async => true);

     await repositoryImpl!.getRandomNumberTrivia();
      verify(mockNetworkInfo!.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo!.isConnected).thenAnswer((_) async => true);
      });
      test('should return data when remote data source is called', () async {
        when(mocktriviaremotedatasource?.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repositoryImpl?.getRandomNumberTrivia();
        verify(mocktriviaremotedatasource!.getRandomNumberTrivia());
        expect(result, Right(tNumberTrivia));
      });
      test(
          'should cached the data locally when the call to remote data source is successful',
          () async {
        when(mocktriviaremotedatasource?.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        await repositoryImpl?.getRandomNumberTrivia();
        verify(mocktriviaremotedatasource!.getRandomNumberTrivia());
        verify(mockLocalDataSource!.cacheNumberTrivia(tNumberTriviaModel));
      });

      test(
          'should return server failure when remote data source is unsuccessful',
          () async {
        when(mocktriviaremotedatasource?.getRandomNumberTrivia())
            .thenThrow(ServerException());

        final result = await repositoryImpl?.getRandomNumberTrivia();
        verify(mocktriviaremotedatasource!.getRandomNumberTrivia());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, Left(ServerFailure()));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo!.isConnected).thenAnswer((_) async => false);
      });
      test(
          'should return the last locally cahed data when the cached data is present',
          () async {
        // arrange
        when(mockLocalDataSource!.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repositoryImpl!.getRandomNumberTrivia();

        //assert
        verifyZeroInteractions(mocktriviaremotedatasource);
        verify(mockLocalDataSource!.getLastNumberTrivia());
        expect(result, right(tNumberTrivia));
      });

      test('should return cache failure when there is no cahed data available',
          () async {
        // arrange
        when(mockLocalDataSource!.getLastNumberTrivia())
            .thenThrow(CacheException());
        //act
        final result = await repositoryImpl!.getRandomNumberTrivia();

        //assert
        verify(mockLocalDataSource!.getLastNumberTrivia());
        verifyZeroInteractions(mocktriviaremotedatasource);
        expect(result, Left(CacheFailure()));
      });
    });
  });
}
