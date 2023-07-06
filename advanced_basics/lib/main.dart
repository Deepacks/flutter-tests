import 'package:flutter/material.dart';

import 'screen_shell.dart';
import 'screens/start_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Scaffold(
        body: ScreenShell(
          StartScreen(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
