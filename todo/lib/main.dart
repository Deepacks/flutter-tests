import 'package:flutter/material.dart';

import 'screen/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo",
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          foregroundColor:
              ThemeData.estimateBrightnessForColor(Colors.deepPurpleAccent) ==
                      Brightness.dark
                  ? Colors.white
                  : Colors.black,
          backgroundColor: Colors.deepPurpleAccent,
        ),
      ),
    );
  }
}
