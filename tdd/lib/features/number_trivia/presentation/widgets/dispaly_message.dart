// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

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