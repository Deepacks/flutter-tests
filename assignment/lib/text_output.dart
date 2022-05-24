import 'package:flutter/material.dart';

class TextOutput extends StatelessWidget {
  final String bodyText;

  const TextOutput(this.bodyText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Text(
        bodyText,
        style: const TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      ),
    );
  }
}
