// ignore_for_file: prefer_const_declarations
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
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
      repositoryImpl!.getConcreteNumberTrivia(tNumber);
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
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo!.isConnected).thenAnswer((_) async => false);
      });
    });
  });
}
