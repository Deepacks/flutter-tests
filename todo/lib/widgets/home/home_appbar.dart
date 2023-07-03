import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key, required this.onResetTodos});

  final VoidCallback onResetTodos;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Todos"),
      actions: [
        IconButton(
          onPressed: onResetTodos,
          icon: const Icon(
            Icons.refresh,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
