import 'package:get_it/get_it.dart';
import 'package:tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final getit = GetIt.instance;

void init() {
  //! Features -NumberTrivia
  //bloc
  getit.registerFactory(() => NumberTriviaBloc(getConcreteNumberTrivia: getit(),
   getRandomNumberTrivia: getit()
   , inputConverter: getit()
   )
   );
  //! Core

  //! External
}
