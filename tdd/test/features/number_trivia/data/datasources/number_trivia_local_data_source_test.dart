import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSourceImpl? numberTriviaLocalDataSource;
  MockSharedPreferences? mocksharedpreferences;
  setUp(() {
    numberTriviaLocalDataSource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mocksharedpreferences!);
    mocksharedpreferences = MockSharedPreferences();
  });

  group("", () {
    
  });
}
