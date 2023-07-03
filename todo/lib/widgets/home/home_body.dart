import 'package:flutter/material.dart';

import '../../models/todo.dart';
import '../gradient_container.dart';
import 'todo_item.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.todos,
    required this.onTodoClick,
    required this.onTodoDelete,
  });

  final List<Todo> todos;
  final ValueChanged<Todo> onTodoClick;
  final ValueChanged<Todo> onTodoDelete;

  @override
  Widget build(BuildContext context) {
    return GradientContainer.purple(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          children: [
            if (todos.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "You got nothing to do yet!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              )
            else
              for (final t in todos)
                TodoItem(
                  priority: todos.indexOf(t) + 1,
                  todo: t,
                  onTodoChanged: onTodoClick,
                  onTodoDeleted: onTodoDelete,
                ),
          ],
        ),
      ),
    );
  }
}
