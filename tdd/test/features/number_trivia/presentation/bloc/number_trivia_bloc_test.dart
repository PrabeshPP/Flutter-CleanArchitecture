import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:tdd/core/usecases/usecase.dart';
import 'package:tdd/core/util/input_converter.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTrivia, GetRandomNumberTrivia, InputConverter])
void main() {
  NumberTriviaBloc? bloc1;
  MockGetConcreteNumberTrivia? mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia? mockRandomNumberTrivia;
  MockInputConverter? mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc1 = NumberTriviaBloc(
        getConcreteNumberTrivia: mockGetConcreteNumberTrivia!,
        getRandomNumberTrivia: mockRandomNumberTrivia!,
        inputConverter: mockInputConverter!);
  });

  test('bloc initialstate should be empty', () {
    expect(bloc1!.state, equals(Empty()));
  });
  const tNumberTrivia = NumberTrivia(text: "Test Text", number: 1);
  group('GetTriviaForConcreteNumber', () {
    const tInvalidStringNumber = 'abc';
    const tStringNumber = "1";
    const tNumber = 1;

    test(
        'Should Call the InputConverter to validate and convert the string to an unsigned integer',
        () async {
      when(mockInputConverter!.stringToInt("1"))
          .thenReturn(const Right(tNumber));
      when(mockGetConcreteNumberTrivia!(const Params(number: 1)))
          .thenAnswer((_) async => const Right(tNumberTrivia));
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

    test("Should emit Loaded when the data is gotten successfully", () async {
      when(mockInputConverter!.stringToInt(tStringNumber))
          .thenReturn(const Right(tNumber));
      when(mockGetConcreteNumberTrivia!(const Params(number: 1)))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      bloc1!.add(const GetTriviaForConcreteNumber(tStringNumber));
      await untilCalled(mockInputConverter!.stringToInt('1'));
      await mockGetConcreteNumberTrivia!(const Params(number: tNumber));
      expect(bloc1!.state, equals(const Loaded(numberTrivia: tNumberTrivia)));
    });

    test("Should emit error when getting data fails", () async {
      when(mockInputConverter!.stringToInt(tStringNumber))
          .thenReturn(const Right(tNumber));
      when(mockGetConcreteNumberTrivia!(const Params(number: 1)))
          .thenAnswer((_) async => Left(ServerFailure()));
      bloc1!.add(const GetTriviaForConcreteNumber(tStringNumber));
      await untilCalled(mockInputConverter!.stringToInt('1'));
      await mockGetConcreteNumberTrivia!(const Params(number: tNumber));
      expect(bloc1!.state, equals(const Error(Server_Failure_Message)));
    });

    test(
        "Should emit error with a proper message for the error when getting the failure",
        () async {
      when(mockInputConverter!.stringToInt(tStringNumber))
          .thenReturn(const Right(tNumber));
      when(mockGetConcreteNumberTrivia!(const Params(number: 1)))
          .thenAnswer((_) async => Left(CacheFailure()));
      bloc1!.add(const GetTriviaForConcreteNumber(tStringNumber));
      await untilCalled(mockInputConverter!.stringToInt('1'));
      await mockGetConcreteNumberTrivia!(const Params(number: tNumber));
      expect(bloc1!.state, equals(const Error(Cache_Failure_Message)));
    });
  });

  group("GetRandomNumberTrivia", () {
    test("Should get the data from the usecases", () async {
      when(mockRandomNumberTrivia!(NoParams()))
          .thenAnswer((realInvocation) async => const Right(tNumberTrivia));
      bloc1!.add(GetTriviaForRandomNumber());
      await untilCalled(mockRandomNumberTrivia!(any));
      verify(mockRandomNumberTrivia!(NoParams()));
    });

    test("Should emit Loaded when the data is gotten successfully", () async {
      when(mockRandomNumberTrivia!(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      bloc1!.add(GetTriviaForRandomNumber());
      await untilCalled(mockRandomNumberTrivia!(any));
      await mockRandomNumberTrivia!(NoParams());
      expect(bloc1!.state, equals(const Loaded(numberTrivia: tNumberTrivia)));
    });
    test("Should emit error when getting data fails", () async {
      when(mockRandomNumberTrivia!(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      bloc1!.add(GetTriviaForRandomNumber());
      await untilCalled(mockRandomNumberTrivia!(any));
      await mockRandomNumberTrivia!(NoParams());
      expect(bloc1!.state, equals(const Error(Server_Failure_Message)));
    });

     test(
        "Should emit error with a proper message for the error when getting the failure",
        () async {
      when(mockRandomNumberTrivia!(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      bloc1!.add( GetTriviaForRandomNumber());
      await untilCalled(mockRandomNumberTrivia!(any));
      await mockRandomNumberTrivia!(NoParams());
      expect(bloc1!.state, equals(const Error(Cache_Failure_Message)));
    });
  });
}
