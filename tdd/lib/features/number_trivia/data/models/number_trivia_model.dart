// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia{
  NumberTriviaModel({required String text,required int number}) : super(text: text,number:number);

}