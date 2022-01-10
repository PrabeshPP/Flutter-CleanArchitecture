import 'package:mockito/mockito.dart';
import 'package:tdd/features/number_trivia/data/respositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
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
}
