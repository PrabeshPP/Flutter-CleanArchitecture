import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'numbertrivia_event.dart';
part 'numbertrivia_state.dart';

class NumbertriviaBloc extends Bloc<NumbertriviaEvent, NumbertriviaState> {
  NumbertriviaBloc() : super(NumbertriviaInitial()) {
    on<NumbertriviaEvent>((event, emit) {
   
    });
  }
}
