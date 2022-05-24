import 'package:flutter/material.dart';

import 'question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, List<Map<String, Object>>>> questions;
  final int questionIndex;
  final Function(int) answerHandler;

  const Quiz(
      {required this.questions,
      required this.questionIndex,
      required this.answerHandler,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questions[questionIndex].keys.first,
        ),
        ...questions[questionIndex].values.first.map((answer) => Answer(
            () => answerHandler(answer["score"] as int),
            answer["text"] as String))
      ],
    );
  }
}
