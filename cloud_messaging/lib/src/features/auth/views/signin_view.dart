import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/widgets/custom_scaffold.dart';
import '../providers/auth_form_provider.dart';
import '../widget/auth_fields.dart';

class SigninView extends ConsumerWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Login',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthFields(
            title: 'Welcome, Log back in',
            label: 'Sign in',
            loading: ref
                .watch(authFormStateNotifierProvider)
                .maybeWhen(orElse: () => false, loading: () => true),
            onSubmit: (email, password) => ref
                .read(authFormStateNotifierProvider.notifier)
                .login(email: email, password: password),
            link: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () => context.go('/auth/signup'),
                  child: const Text('Sign up'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
