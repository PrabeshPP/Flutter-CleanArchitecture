// ignore_for_file: prefer_const_declarations, prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/usecases/usecase.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockTriviaRepository extends Mock implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia? usecase;
  MockTriviaRepository? mockTriviaRepository;

  setUp(() {
    mockTriviaRepository = MockTriviaRepository();
    usecase = GetRandomNumberTrivia(repository: mockTriviaRepository!);
  });
  final tNumberTrivia = NumberTrivia(text: "test", number: 1);

  test("Should return a random number trivia", () async {
    when(mockTriviaRepository?.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(tNumberTrivia));

    final result = await usecase!(NoParams());
    expect(result, Right(tNumberTrivia));
    verify(mockTriviaRepository!.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockTriviaRepository);
  });
}
