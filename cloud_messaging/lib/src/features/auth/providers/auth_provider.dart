import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data_source/auth_data_source.dart';
import 'state/auth_state.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(ref.read(authDataSourceProvider)),
);

final class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthDataSource _dataSource;

  AuthStateNotifier(
    this._dataSource,
  ) : super(const AuthState.initial()) {
    final user = _dataSource.me();

    state = user == null
        ? const AuthState.unauthenticated()
        : const AuthState.authenticated();
  }

  void onLoggedIn() => state = const AuthState.authenticated();

  Future<void> logout() async {
    await _dataSource.logout();
    state = const AuthState.unauthenticated();
  }
}
