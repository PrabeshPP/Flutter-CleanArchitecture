import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd/core/error/exception.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd/features/number_trivia/data/models/number_trivia_model.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';


@GenerateMocks([SharedPreferences])
void main() {
  NumberTriviaLocalDataSourceImpl? numberTriviaLocalDataSource;
  MockSharedPreferences? mocksharedpreferences;
  setUp(() {
    mocksharedpreferences = MockSharedPreferences();
    numberTriviaLocalDataSource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mocksharedpreferences!);
  });

  group("get Last NumberTrivia", () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(reader('trivia_cached.json')));
    test("Should return NumberTrivia from SharedPreferences", () async {
      when(mocksharedpreferences!.getString("CACHED_NUMBER_TRIVIA"))
          .thenReturn(reader('trivia_cached.json'));
      final result = await numberTriviaLocalDataSource!.getLastNumberTrivia();
      verify(mocksharedpreferences!.getString('CACHED_NUMBER_TRIVIA'));
      expect(result, tNumberTriviaModel);
    });

    test("Should raise the Cache Exception Error when there is no cache data",
        () async {
      // arrange
      when(mocksharedpreferences!.getString(CACHED_NUMBER_TRIVIA))
          .thenReturn(null);

      //act

      final call = numberTriviaLocalDataSource!.getLastNumberTrivia;

      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group("cachedNumber Trivia", () {
    final tNumberTriviaModel = NumberTriviaModel(text: "Text", number: 1);
    test('Should call the sharedpreferences to cache the data', () async {
      numberTriviaLocalDataSource!.cacheNumberTrivia(tNumberTriviaModel);

   
    });
  });
}
