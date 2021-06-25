import 'package:firebase_auth/firebase_auth.dart';
import '../src/sign_in_services/sign_in_service.dart';
import './auth_service.dart';
import './sign_in_services/apple/apple_sign_in_service.dart';
import './sign_in_services/facebook/facebook_sign_in_service.dart';
import './sign_in_services/google/google_sign_in_service.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthService {
  FirebaseAuth _firebaseAuth;
  SignInService _signInMethod;
  SignInService _testingService;

  FirebaseAuthService(
      {FirebaseAuth firebaseAuth, SignInService testingService}) {
    _testingService = testingService;
    _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  }

  @override
  Stream<User> get onAuthStateChanged => _firebaseAuth.authStateChanges();

  @override
  Stream<User> get onUserChanged => _firebaseAuth.userChanges();

  @override
  Future<User> currentUser() async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<User> createUserWithEmailAndPassword({
    String name,
    String lastName,
    String email,
    String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user.updateDisplayName(
        name + ' ' + lastName,
      );
      await userCredential.user.reload();
      return _firebaseAuth.currentUser;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<User> _signInWithAService(SignInService service) async {
    final firebaseCredential = await service.getFirebaseCredential();
    if (firebaseCredential != null) {
      final userCredential = await _firebaseAuth.signInWithCredential(
        firebaseCredential,
      );
      _signInMethod = service;
      return userCredential.user;
    }
    return null;
  }

  @override
  Future<User> signInWithGoogle({GoogleSignIn googleLogin}) async {
    final googleService =
        _testingService ?? GoogleSignInService(signInMethod: googleLogin);
    return _signInWithAService(googleService);
  }

  @override
  Future<User> signInWithFacebook({FacebookAuth facebookLogin}) async {
    final facebookService =
        _testingService ?? FacebookSignInService(signInMethod: facebookLogin);
    return _signInWithAService(facebookService);
  }

  @override
  Future<User> signInWithApple({AppleSignInService appleLogin}) async {
    final appleService = _testingService ?? AppleSignInService();
    return _signInWithAService(appleService);
  }

  @override
  Future<void> signOut() async {
    await _signInMethod?.signOut();
    _signInMethod = null;
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> changeProfile(
      {String firstName, String lastName, String photoURL}) async {
    try {
      final user = _firebaseAuth.currentUser;
      await user.updateDisplayName('$firstName $lastName');
      if (photoURL != null) {
        await user.updatePhotoURL(photoURL);
      }
      return true;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      await user.delete();
      return true;
    } catch (e) {
      throw e;
    }
  }
}
