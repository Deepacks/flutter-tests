import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/widgets/custom_scaffold.dart';
import '../providers/auth_form_provider.dart';
import '../widget/auth_fields.dart';

class SignupView extends ConsumerWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Signup',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthFields(
            title: 'Welcome, Create your Account',
            loading: ref
                .watch(authFormStateNotifierProvider)
                .maybeWhen(orElse: () => false, loading: () => true),
            label: 'Sign up',
            onSubmit: (email, password) => ref
                .read(authFormStateNotifierProvider.notifier)
                .signup(email: email, password: password),
          ),
        ],
      ),
    );
  }
}
