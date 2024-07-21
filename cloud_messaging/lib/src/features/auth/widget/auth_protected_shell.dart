import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/widgets/custom_scaffold.dart';
import '../providers/auth_provider.dart';

class AuthProtectedShell extends ConsumerWidget {
  final Widget child;

  const AuthProtectedShell(this.child, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(authStateNotifierProvider);

    return userState.maybeWhen(
      orElse: () => CustomScaffold.empty(),
      unauthenticated: () {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => context.go('/auth'),
        );

        return CustomScaffold.empty();
      },
      authenticated: () => child,
    );
  }
}
