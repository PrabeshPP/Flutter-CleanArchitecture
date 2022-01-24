import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'numbertrivia_event.dart';
part 'numbertrivia_state.dart';

class NumbertriviaBloc extends Bloc<NumbertriviaEvent, NumbertriviaState> {
  NumbertriviaBloc() : super(NumbertriviaInitial()) {
    on<NumbertriviaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
