import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Text("Hello World!"),
      ),
    ),
    debugShowCheckedModeBanner: false,
  ));
}
