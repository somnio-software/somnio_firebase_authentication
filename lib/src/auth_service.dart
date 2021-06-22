part of somnio_firebase_authentication;

abstract class AuthService {
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword({
    String name,
    String lastName,
    String email,
    String password,
  });
  Future<void> sendPasswordResetEmail(String email);
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<User> signInWithApple();
  Future<void> signOut();
  Future<bool> changeProfile(
      {String firstName, String lastName, String photoURL});
  Future<bool> deleteAccount();
}
