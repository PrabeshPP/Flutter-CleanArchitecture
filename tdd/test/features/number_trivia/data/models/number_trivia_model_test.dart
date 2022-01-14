import 'dart:convert';
import 'package:tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(text: "Test Text", number: 1);
  test("Should be a subclass of the NumberTriviaEntity", () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group("fromJson", () {
    test("Should return a valid model when the Json Number is an Integer",
        () async {
      final Map<String, dynamic> jsonMap =
          await jsonDecode(reader("trivia.json"));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, equals(tNumberTriviaModel));
    });
    test("Should return a valid model when the Json Number is double",
        () async {
      final Map<String, dynamic> jsonMap1 =
          await jsonDecode(reader("trivia_double.json"));
      final result = NumberTriviaModel.fromJson(jsonMap1);
      expect(result, tNumberTriviaModel);
    });
  });

  group('toJson', () {
    test("Should return the proper data for our model", () async {
      final result = tNumberTriviaModel.toJSon();
      final expectedMap = {
        "text": "Test Text",
        "number": 1,
      };
      expect(result, expectedMap);
    });
  });
}
