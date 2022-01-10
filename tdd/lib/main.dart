import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: selected?400.0:200.0,
              height:selected?300.0:200.0 ,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Image.network(
                  "https://pbs.twimg.com/media/Eu7kZRRWgAMJjj8.png"),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                        selected = !selected;
                  });
              
                },
                child: const Text("Click me"))
          ],
        ),
      ),
    );
  }
}
