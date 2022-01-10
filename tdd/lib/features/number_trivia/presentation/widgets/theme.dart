import 'package:flutter/material.dart';

class Mytheme {
  static lightTheme(BuildContext context) => ThemeData(
    primarySwatch:Colors.lightGreen,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: Colors.green[300],
     titleTextStyle: const TextStyle(
       fontSize: 20.0,
       color: Colors.white
     )
    )
  );
}
