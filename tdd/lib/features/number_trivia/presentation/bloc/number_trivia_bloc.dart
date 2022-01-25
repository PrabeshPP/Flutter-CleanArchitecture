import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    // on<NumberTriviaEvent>((event, emit) {});
    on<GetTriviaForConcreteNumber>(_onGetTriviaConcreteNumber);
  }

  void _onGetTriviaConcreteNumber(
      GetTriviaForConcreteNumber event, Emitter<NumberTriviaState> emit) async {
    final inputEither = _inputConverter.stringToInt(event.numberString);
    inputEither!.fold((failure) => emit(const Error(InvalidIn_Failure_Message)),
        (number) async {
          emit(Loading());
      final failureorTrivia =
          await _getConcreteNumberTrivia(Params(number: number));

      failureorTrivia!.fold((l) => emit(const Error(Cache_Failure_Message)),
          (r) => emit(Loaded(numberTrivia: r!)));
      
    });
  }
}
