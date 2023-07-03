import 'package:flutter/material.dart';

import '../../models/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.priority,
    required this.todo,
    required this.onTodoChanged,
    required this.onTodoDeleted,
  });

  final int priority;
  final Todo todo;
  final ValueChanged<Todo> onTodoChanged;
  final ValueChanged<Todo> onTodoDeleted;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) {
      return const TextStyle(
        color: Colors.white,
      );
    }

    return const TextStyle(
      color: Colors.white70,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(priority),
      onDismissed: (_) => onTodoDeleted(todo),
      background: Container(
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        onTap: () {
          onTodoChanged(todo);
        },
        leading: CircleAvatar(
          child: Text(
            priority.toString(),
          ),
        ),
        title: Text(
          todo.name,
          style: _getTextStyle(todo.checked),
        ),
      ),
    );
  }
}
