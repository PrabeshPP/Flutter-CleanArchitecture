// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({required String text, required int number})
      : super(text: text, number: number);
  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      NumberTriviaModel(
          text: json['text'], number: (json['number'] as num).toInt());
  Map<String, dynamic> toJSon() => {"text": text, "number": number};
}
