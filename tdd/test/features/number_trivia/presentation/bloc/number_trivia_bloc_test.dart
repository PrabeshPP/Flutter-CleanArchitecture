import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/core/util/input_converter.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc? bloc1;
  MockGetConcreteNumberTrivia? mockGetConcreteNumberTrivia;
  MockRandomNumberTrivia? mockRandomNumberTrivia;
  MockInputConverter? mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockRandomNumberTrivia = MockRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc1 = NumberTriviaBloc(
        getConcreteNumberTrivia: mockGetConcreteNumberTrivia!,
        getRandomNumberTrivia: mockRandomNumberTrivia!,
        inputConverter: mockInputConverter!);
  });

  test('bloc initialstate should be empty', () {
    expect(bloc1!.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    const tInvalidStringNumber = 'abc';
    const tStringNumber = "1";
    const tNumber = 1;
    const tNumberTrivia = NumberTrivia(text: "Test Text", number: 1);
    test(
        'Should Call the InputConverter to validate and convert the string to an unsigned integer',
        () async {
      when(mockInputConverter!.stringToInt("1"))
          .thenReturn(const Right(tNumber));
      bloc1!.add(const GetTriviaForConcreteNumber(tStringNumber));
      await untilCalled(mockInputConverter!.stringToInt('1'));
      verify(mockInputConverter!.stringToInt(tStringNumber));
    });

    test('Should emit[error] when the input is invalid', () async {
      when(mockInputConverter!.stringToInt(tInvalidStringNumber))
          .thenReturn(Left(InvalidInputFailure()));

      bloc1!.add(const GetTriviaForConcreteNumber(tInvalidStringNumber));
      await untilCalled(mockInputConverter!.stringToInt('abc'));
      expect(bloc1!.state, equals(const Error(InvalidIn_Failure_Message)));
    });

    test("should get data from the concrete use case", () async {
      when(mockInputConverter!.stringToInt(tStringNumber))
          .thenReturn(const Right(tNumber));
      when(mockGetConcreteNumberTrivia!(const Params(number: 1)))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      bloc1!.add(const GetTriviaForConcreteNumber(tStringNumber));
      await untilCalled(mockInputConverter!.stringToInt('1'));
      verify(mockGetConcreteNumberTrivia!(const Params(number: tNumber)));
      
    });
  });
}
