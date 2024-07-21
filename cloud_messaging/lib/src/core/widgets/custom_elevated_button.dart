import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool disabled;

  const CustomElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: ElevatedButton(
        onPressed: disabled ? () {} : onPressed,
        child: child,
      ),
    );
  }
}
