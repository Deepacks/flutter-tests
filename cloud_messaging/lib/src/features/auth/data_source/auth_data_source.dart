import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/firebase_auth_provider.dart';

final authDataSourceProvider = Provider<AuthDataSource>(
  (ref) => AuthDataSource(
    ref.read(firebaseAuthProvider),
  ),
);

class AuthDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthDataSource(this._firebaseAuth);

  Future<Either<String, void>> signup({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to Signup.');
    }
  }

  Future<Either<String, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to Login');
    }
  }

  Future<Either<String, void>> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);

        return right(null);
      } else {
        return left('Google login canceled');
      }
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Unknow Error');
    }
  }

  User? me() => _firebaseAuth.currentUser;

  Future<void> logout() => _firebaseAuth.signOut();
}
