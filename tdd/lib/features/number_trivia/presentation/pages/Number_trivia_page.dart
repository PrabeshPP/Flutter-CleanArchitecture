// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:tdd/injection_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number trivia"),
      ),
      body: BlocProvider(
        create: (_) => getit<NumberTriviaBloc>(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                    builder: (context, state) {
                 
                  if (state is Empty) {
                    return const DispalyMessage(message: "Start Searching!");
                  } else if (state is Loading) {
                    return const LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDispaly(numberTrivia: state.numberTrivia);
                  } else if (state is Error) {
                    return DispalyMessage(message: state.message);
                  } else {
                    return const Text("Hello");
                  }
                })),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "Enter a Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)))),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {}, child: const Text("Number Trivia")),
                ElevatedButton(
                    onPressed: () {}, child: const Text("Random Trivia"))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DispalyMessage extends StatelessWidget {
  final String message;
  const DispalyMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height / 3,
        child: Center(
          child: SingleChildScrollView(
            child: Text(
              message,
              style: const TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
        ));
    ;
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height / 3,
        child: const Center(child: CircularProgressIndicator()));
  }
}

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
