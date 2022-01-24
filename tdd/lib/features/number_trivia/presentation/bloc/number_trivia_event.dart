part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  @override
  List<Object> get props=>[];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {
  @override
  List<Object> get props => [];
}
