import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/widgets/custom_elevated_button.dart';
import '../providers/auth_form_provider.dart';

class AuthFields extends HookConsumerWidget {
  final String title;
  final String label;
  final Future<void> Function(String email, String password) onSubmit;
  final bool loading;
  final Widget? link;

  const AuthFields({
    super.key,
    required this.title,
    required this.label,
    required this.onSubmit,
    this.loading = false,
    this.link,
  });

  Future<void> _handleLogin(
    BuildContext context,
    Future<void> Function() loginFn,
  ) async {
    await loginFn();
    if (context.mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    ref.listen(authFormStateNotifierProvider, (prev, next) {
      next.maybeWhen(
        orElse: () => null,
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      );
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(hintText: 'Email'),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(hintText: 'Password'),
        ),
        const SizedBox(height: 30),
        Center(
          child: CustomElevatedButton(
            disabled: loading,
            onPressed: () => _handleLogin(
              context,
              () => onSubmit(
                emailController.text.trim(),
                passwordController.text,
              ),
            ),
            child: Text(label),
          ),
        ),
        if (link != null)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              link!,
            ],
          ),
        const SizedBox(height: 30),
        Center(
          child: SignInButton(
            Buttons.GoogleDark,
            onPressed: () => _handleLogin(
              context,
              () => ref
                  .read(authFormStateNotifierProvider.notifier)
                  .loginWithGoogle(),
            ),
          ),
        ),
      ],
    );
  }
}
