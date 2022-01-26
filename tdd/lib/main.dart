import 'package:flutter/material.dart';
import 'package:tdd/features/number_trivia/presentation/pages/app_view.dart';
import 'package:tdd/features/number_trivia/presentation/widgets/theme.dart';
import 'package:tdd/injection_container.dart' as di;

void main() async{
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      themeMode: ThemeMode.light,
      theme: Mytheme.lightTheme(context),
    );
  }
}
