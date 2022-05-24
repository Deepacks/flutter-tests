import 'package:flutter/material.dart';

import 'text_output.dart';

class TextControl extends StatefulWidget {
  const TextControl({Key? key}) : super(key: key);

  @override
  State<TextControl> createState() => _TextControlState();
}

class _TextControlState extends State<TextControl> {
  var _bodyText = "This my first actual app";

  void _handleClick() {
    setState(() {
      _bodyText = _bodyText == "This my first actual app"
          ? "Very cool indeed"
          : "This my first actual app";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextOutput(_bodyText),
        OutlinedButton(
          onPressed: _handleClick,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.blue),
          ),
          child: const Text(
            "Yooo",
            style: TextStyle(fontSize: 30),
          ),
        )
      ],
    );
  }
}
