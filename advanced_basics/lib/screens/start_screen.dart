import 'package:flutter/material.dart';

import '../widgets/styled_text.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          const SizedBox(height: 80),
          const StyledText('Learn flutter the fun way!'),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(
                width: 1.0,
                color: Color.fromARGB(113, 255, 255, 255),
              ),
            ),
            child: const Text('Start Quiz'),
          )
        ],
      ),
    );
  }
}
