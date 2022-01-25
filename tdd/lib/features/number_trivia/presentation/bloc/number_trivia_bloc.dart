// ignore_for_file: constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:tdd/core/usecases/usecase.dart';
import 'package:tdd/core/util/input_converter.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const Server_Failure_Message = "Server Failure";
const Cache_Failure_Message = "Cache Failure";
const InvalidIn_Failure_Message = "Input Converter Failure Message";

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia _getConcreteNumberTrivia;
  final GetRandomNumberTrivia _getRandomNumberTrivia;
  final InputConverter _inputConverter;
  NumberTriviaBloc(
      {required GetConcreteNumberTrivia getConcreteNumberTrivia,
      required GetRandomNumberTrivia getRandomNumberTrivia,
      required InputConverter inputConverter})
      : _getConcreteNumberTrivia = getConcreteNumberTrivia,
        _getRandomNumberTrivia = getRandomNumberTrivia,
        _inputConverter = inputConverter,
        super(Empty()) {
    on<GetTriviaForConcreteNumber>(_onGetTriviaConcreteNumber);
    on<GetTriviaForRandomNumber>(_onGetTriviaRandomNumber);
  }

  void _onGetTriviaConcreteNumber(
      GetTriviaForConcreteNumber event, Emitter<NumberTriviaState> emit) async {
    final inputEither = _inputConverter.stringToInt(event.numberString);
    inputEither!.fold((failure) => emit(const Error(InvalidIn_Failure_Message)),
        (number) async {
      emit(Loading());
      final failureorTrivia =
          await _getConcreteNumberTrivia(Params(number: number));

      failureorTrivia!.fold((l) => emit(Error(_mapFailureToMessage(l))),
          (r) => emit(Loaded(numberTrivia: r!)));
    });
  }

  void _onGetTriviaRandomNumber(
      GetTriviaForRandomNumber event, Emitter<NumberTriviaState> emit) async {
    emit(Loading());
    final failureOrTrivia = await _getRandomNumberTrivia(NoParams());
    failureOrTrivia!.fold((l) => emit(Error(_mapFailureToMessage(l))), (numberTrivia)
     => emit(Loaded(numberTrivia: numberTrivia!)));
  }

  String _mapFailureToMessage(Failure? failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return Cache_Failure_Message;
      case ServerFailure:
        return Server_Failure_Message;
      default:
        return "Unexpected Error";
    }
  }
}
