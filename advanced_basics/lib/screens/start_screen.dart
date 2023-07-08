import 'package:flutter/material.dart';

import '../widgets/styled_text.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.onQuizStart, {super.key});

  final VoidCallback onQuizStart;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: MediaQuery.of(context).size.width * 0.5,
            color: const Color.fromARGB(150, 255, 255, 255),
          ),
          const SizedBox(height: 60),
          const StyledText('Learn flutter the fun way!'),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: onQuizStart,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(
                width: 1.0,
                color: Color.fromARGB(150, 255, 255, 255),
              ),
            ),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Start Quiz'),
          )
        ],
      ),
    );
  }
}
