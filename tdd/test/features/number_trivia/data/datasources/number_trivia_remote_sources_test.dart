// ignore_for_file: prefer_const_declarations

import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/error/exception.dart';
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
  String url = "numberapi.com";
  final tNumberTriviaModel =
      NumberTriviaModel.fromJson(jsonDecode(reader("trivia.json")));
  group("Concrete Number Trivia", () {
    final tNumber = 1;

    test("should perform a GET request on a URL with number being the endpoint",
        () async {
      final locationRequest = Uri.http(url, "/$tNumber");
      // arrange
      when(mockHttpClient!.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(reader('trivia.json'), 200));

      // //act
      numberTriviaRemoteDataSourceImpl!.getConcreteNumberTrivia(tNumber);
      // //assert

      verify(await mockHttpClient!
          .get(locationRequest, headers: {"Content-Type": "application/json"}));
    });

    test("should return the number trivia when the response code is 200",
        () async {
      String url = "numberapi.com";
      final locationRequest = Uri.http(url, "/$tNumber");
      // arrange
      when(mockHttpClient!.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(reader('trivia.json'), 200));

      // //act
      final result = await numberTriviaRemoteDataSourceImpl!
          .getConcreteNumberTrivia(tNumber);
      // //assert

      verify(await mockHttpClient!
          .get(locationRequest, headers: {"Content-Type": "application/json"}));

      expect(result, tNumberTriviaModel);
    });

    test("should return Server Failure when the response.statusCode !=200",
        () async {
      when(mockHttpClient!.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response("Something went wrong", 404));

      final call = numberTriviaRemoteDataSourceImpl!.getConcreteNumberTrivia;

      //assert

      expect(
          () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('Get Random Number Trivia', () {
    test(
        'should call the get method when the the getRandom number is triggered ',
        () async {
      //arrange
      when(mockHttpClient!.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(reader("trivia.json"), 200));

      // act

      numberTriviaRemoteDataSourceImpl!.getRandomNumberTrivia();
      final locationRequest = Uri.http(url, "/random");
      //verify
      verify(mockHttpClient!
          .get(locationRequest, headers: {'Content-Type': '?json'}));
    });

    test('Should return the Number Trivia Model when the response is 200',
        () async {
      //arrange
      when(mockHttpClient!.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(reader('trivia.json'), 200));
      //act
      final numbertriviamodel =
          await numberTriviaRemoteDataSourceImpl!.getRandomNumberTrivia();

      //assert
      final locationRequest = Uri.http(url, "/random");
      verify(mockHttpClient!
          .get(locationRequest, headers: {'Content-Type': '?json'}));
      expect(numbertriviamodel, tNumberTriviaModel);
    });

    test("Should thow server exception when the statusCode is not equal to 200",
        () async {
      //arrange
      when(mockHttpClient!.get(any,headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async => http.Response("Something went Wrong", 404));
//act
      final call = numberTriviaRemoteDataSourceImpl!.getRandomNumberTrivia;
//assert
      expect(() => call(),throwsA( const TypeMatcher<ServerException>()) );
    });
  });
}
