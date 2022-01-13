import 'package:tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
final tNumberTrivia = NumberTriviaModel(text: "Test Text", number: 1);
  test("Should be a subclass of the NumberTriviaEntity", () async {
    expect(tNumberTrivia, isA<NumberTrivia>());
  });
}
