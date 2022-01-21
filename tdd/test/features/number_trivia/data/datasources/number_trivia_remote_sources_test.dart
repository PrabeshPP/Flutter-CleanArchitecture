// ignore_for_file: prefer_const_declarations

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_remote_sources.dart';
import 'package:tdd/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
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


  group("Concrete Number Trivia", () {
    final tNumber = 1;

    test("should perform a GET request on a URL with number being the endpoint",
        () async {
      String url = "numberapi.com";
      final locationRequest = Uri.http(url, "/$tNumber");
      // arrange
      when(mockHttpClient!.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(reader('trivia.json'), 200));

      // //act
      numberTriviaRemoteDataSourceImpl!.getConcreteNumberTrivia(tNumber);
      // //assert

      verify(await mockHttpClient!.get(locationRequest,headers:{"Content-Type":"application/json"}));
    });
  });
}
