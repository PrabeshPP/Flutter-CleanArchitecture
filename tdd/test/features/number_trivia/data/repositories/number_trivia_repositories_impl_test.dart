import 'package:mockito/mockito.dart';
import 'package:tdd/core/platform/network_info.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_remote_sources.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/features/number_trivia/data/respositories/number_trivia_repository_impl.dart';

class Mocktriviaremotedatasource extends Mock
    implements NumberTriviaRemoteSources {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl repositoryImpl;
  Mocktriviaremotedatasource mocktriviaremotedatasource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mocktriviaremotedatasource = Mocktriviaremotedatasource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = NumberTriviaRepositoryImpl(
        numberTriviaRemoteSources: mocktriviaremotedatasource,
        numberTriviaLocalDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  test("Should  ", () {});
}
