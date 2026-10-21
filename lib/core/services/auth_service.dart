import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ── Currently signed-in user (null if signed out) ──
  User? get currentUser => _auth.currentUser;

  // ── Stream that fires whenever auth state changes ──
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ── Register a new account ────────────────────────
  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(name);

      return null;
    } on FirebaseAuthException catch (e) {
  print('🔴 FirebaseAuthException code: ${e.code}, message: ${e.message}');
  return _mapErrorMessage(e.code);
} catch (e) {
  print('🔴 Unexpected error: $e');
  return 'Something went wrong. Please try again.';
}
  }

  // ── Sign in an existing account ───────────────────
  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
   } on FirebaseAuthException catch (e) {
  print('🔴 FirebaseAuthException code: ${e.code}, message: ${e.message}');
  return _mapErrorMessage(e.code);
} catch (e) {
  print('🔴 Unexpected error: $e');
  return 'Something went wrong. Please try again.';
}
  }

  // ── Sign out ───────────────────────────────────────
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ── Convert Firebase's error codes to friendly messages ──
  String _mapErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}