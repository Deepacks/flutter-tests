import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/views/signin_view.dart';
import '../features/auth/views/signup_view.dart';
import '../features/auth/widget/auth_protected_shell.dart';
import '../features/home/views/home_view.dart';
import 'widgets/custom_scaffold.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/auth',
      builder: (context, state) => const SigninView(),
      routes: [
        GoRoute(
          path: 'signup',
          builder: (context, state) => const SignupView(),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) => AuthProtectedShell(child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeView(),
          routes: [
            GoRoute(
              path: 'route',
              builder: (context, state) => const CustomScaffold(
                title: 'Main view',
                body: Text('hello'),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
