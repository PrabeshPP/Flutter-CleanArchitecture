part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia numberTrivia;
  const Loaded({required this.numberTrivia});

  @override
  List<Object> get props => [numberTrivia];
}

class Error extends NumberTriviaState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}
