import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetQuiz;

  const Result(this.resultScore, this.resetQuiz, {Key? key}) : super(key: key);

  String get resultPhrase {
    String resultText;
    if (resultScore <= 8) {
      resultText = "You are mentally stable";
    } else if (resultScore <= 15) {
      resultText = "You are mentally unstable";
    } else if (resultScore <= 20) {
      resultText = "You are borderline crazy";
    } else {
      resultText = "You are completely bonkers";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: resetQuiz,
            child: const Text(
              "Restart",
            ),
          )
        ],
      ),
    );
  }
}
