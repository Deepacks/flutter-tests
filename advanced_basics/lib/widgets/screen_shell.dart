import 'package:flutter/material.dart';

class ScreenShell extends StatelessWidget {
  const ScreenShell(this.child, {super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 103, 58, 183),
              Color.fromARGB(255, 121, 58, 183),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: child,
        ),
      ),
    );
  }
}
