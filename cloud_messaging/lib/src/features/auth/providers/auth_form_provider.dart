import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data_source/auth_data_source.dart';
import 'auth_provider.dart';
import 'state/auth_form_state.dart';

final authFormStateNotifierProvider =
    StateNotifierProvider.autoDispose<AuthFormStateNotifier, AuthFormState>(
  (ref) => AuthFormStateNotifier(
    ref.read(authDataSourceProvider),
    ref.read(authStateNotifierProvider.notifier).onLoggedIn,
  ),
);

class AuthFormStateNotifier extends StateNotifier<AuthFormState> {
  final AuthDataSource _dataSource;
  final void Function() _onLoggedIn;

  AuthFormStateNotifier(
    this._dataSource,
    this._onLoggedIn,
  ) : super(const AuthFormState.initial());

  Future<void> login({required String email, required String password}) async {
    state = const AuthFormState.loading();

    final response = await _dataSource.login(email: email, password: password);

    response.fold(
      (error) => state = AuthFormState.error(message: error),
      (_) => _onLoggedIn(),
    );
  }

  Future<void> signup({required String email, required String password}) async {
    state = const AuthFormState.loading();

    final response = await _dataSource.signup(email: email, password: password);

    response.fold(
      (error) => state = AuthFormState.error(message: error),
      (_) => _onLoggedIn(),
    );
  }

  Future<void> loginWithGoogle() async {
    state = const AuthFormState.loading();

    final response = await _dataSource.loginWithGoogle();

    response.fold(
      (error) => state = AuthFormState.error(message: error),
      (_) => _onLoggedIn(),
    );
  }
}
