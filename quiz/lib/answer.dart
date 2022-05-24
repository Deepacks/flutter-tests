import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback answerHandler;
  final String answerText;

  const Answer(this.answerHandler, this.answerText, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: answerHandler,
        child: Text(
          answerText,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
