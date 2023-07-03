import 'package:flutter/material.dart';

import 'dice.dart';
import 'gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          colors: [
            Color.fromARGB(255, 195, 202, 58),
            Color.fromARGB(255, 160, 71, 175),
          ],
          child: Dice(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
