import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {
  void main() {
    GetConcreteNumberTrivia usecase;
    MockNumberTriviaRepository mockNumberTriviaRepository;
    setUp(() {
      mockNumberTriviaRepository = MockNumberTriviaRepository();
      usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
    });
  }

  final tNumber = 1;
  final tNumbertrivia = const NumberTrivia(text: "test", number: 1);

  test();
}
