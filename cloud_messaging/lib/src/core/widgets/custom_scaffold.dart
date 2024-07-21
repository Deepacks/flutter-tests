import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const CustomScaffold({
    super.key,
    required this.title,
    required this.body,
  });

  factory CustomScaffold.empty() {
    return const CustomScaffold(
      title: '',
      body: SizedBox(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: body,
      ),
    );
  }
}
