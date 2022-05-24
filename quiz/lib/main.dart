import 'package:flutter/material.dart';

import 'package:f_c_g/result.dart';
import 'package:f_c_g/quiz.dart';

void main(List<String> args) => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'What\'s your favourite color?': [
        {'text': 'Black', "score": 10},
        {'text': 'Red', "score": 5},
        {'text': 'Green', "score": 3},
        {'text': 'White', "score": 1},
      ]
    },
    {
      'What\'s your favorite animal?': [
        {'text': 'Rabbit', "score": 6},
        {'text': 'Snake', "score": 4},
        {'text': 'Elephant', "score": 2},
        {'text': 'Lion', "score": 1},
      ]
    },
    {
      'What\'s your favorite plane manufacturer?': [
        {'text': 'Bombardier', "score": 8},
        {'text': 'Embraer', "score": 7},
        {'text': 'Boeing', "score": 2},
        {'text': 'Airbus', "score": 1},
      ]
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _handleAnswer(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
    });
    _totalScore = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My first attempt'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                questions: _questions,
                questionIndex: _questionIndex,
                answerHandler: _handleAnswer,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
