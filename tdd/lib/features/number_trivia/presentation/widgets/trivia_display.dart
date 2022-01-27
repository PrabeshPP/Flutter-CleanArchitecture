// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';

class TriviaDispaly extends StatelessWidget {
  final NumberTrivia numberTrivia;
  const TriviaDispaly({Key? key, required this.numberTrivia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height / 3,
        child:  Column(
            children: [
              Text(
                numberTrivia.number.toString(),
                style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      numberTrivia.text,
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
    ;
  }
}