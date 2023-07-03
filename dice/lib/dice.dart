import 'dart:math';
import 'package:flutter/material.dart';

import 'styled_text.dart';

final random = Random();

class Dice extends StatefulWidget {
  const Dice({super.key});

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  var currentDiceFace = 1;

  void rollDice() {
    setState(() {
      currentDiceFace = random.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/dice-$currentDiceFace.png',
            width: MediaQuery.of(context).size.width / 1.7,
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: rollDice,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: const StyledText("Roll Dice"),
          )
        ],
      ),
    );
  }
}
