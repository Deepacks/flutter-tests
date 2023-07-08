import 'package:flutter/material.dart';

import 'screens/questions_screen.dart';
import 'screens/start_screen.dart';
import 'widgets/screen_shell.dart';

void main() {
  runApp(const Quiz());
}

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  late Widget activeScreen;

  @override
  void initState() {
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  void switchScreen() {
    setState(() {
      activeScreen = const QuestionsScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: ScreenShell(
        activeScreen,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
