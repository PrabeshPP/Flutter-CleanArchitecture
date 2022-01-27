import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: const Placeholder(),
              ),
            ),
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