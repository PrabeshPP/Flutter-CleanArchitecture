import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Mytheme {
  static lightTheme(BuildContext context) => ThemeData(
    
    primarySwatch:Colors.lightGreen,
    appBarTheme: AppBarTheme(
      
      systemOverlayStyle:const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:Brightness.light,
      ),
      elevation: 0.0,
      backgroundColor: Colors.green[300],
     titleTextStyle: const TextStyle(
       fontSize: 20.0,
       color: Colors.white
     )
    )
  );
}
