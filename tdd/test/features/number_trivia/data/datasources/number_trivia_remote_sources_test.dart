import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_remote_sources.dart';

import 'number_trivia_remote_sources_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  MockClient? mockHttpClient;
  NumberTriviaRemoteSourcesImpl? numberTriviaRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockClient();
    numberTriviaRemoteDataSourceImpl =
        NumberTriviaRemoteSourcesImpl(httpClient: mockHttpClient!);
  });

group("", (){
  test("", ()async{

  });
})
}
