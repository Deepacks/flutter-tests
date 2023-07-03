import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../widgets/home/home_appbar.dart';
import '../widgets/home/home_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textFieldController = TextEditingController();
  List<Todo> _todos = [];

  void _resetTodos() {
    setState(() {
      _todos.clear();
    });
  }

  void _toggleTodoChecked(Todo todo) {
    setState(() {
      _todos = _todos.map((t) {
        if (t.name == todo.name) {
          return t.copyWith(
            checked: !t.checked,
          );
        }

        return t;
      }).toList();
      todo.checked = !todo.checked;
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _todos = _todos.where((t) => t.name != todo.name).toList();
    });
  }

  void _addTodoItem(String name) {
    setState(
      () {
        _todos = [
          ..._todos,
          Todo(
            name: name,
            checked: false,
          ),
        ];
      },
    );
    _textFieldController.clear();
  }

  Future<void> _displayDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new task'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(
              hintText: 'Type your new task',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(
        onResetTodos: _resetTodos,
      ),
      body: HomeBody(
        todos: _todos,
        onTodoClick: _toggleTodoChecked,
        onTodoDelete: _deleteTodo,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(context),
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
