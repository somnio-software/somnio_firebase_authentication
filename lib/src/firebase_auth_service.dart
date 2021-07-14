import 'package:firebase_auth/firebase_auth.dart';
import 'package:somnio_firebase_authentication/src/exceptions/email_already_in_use.dart';
import 'package:somnio_firebase_authentication/src/exceptions/invalid_credential.dart';
import 'package:somnio_firebase_authentication/src/exceptions/invalid_email.dart';
import 'package:somnio_firebase_authentication/src/exceptions/operation_not_allowed.dart';
import 'package:somnio_firebase_authentication/src/exceptions/requires_recent_login.dart';
import 'package:somnio_firebase_authentication/src/exceptions/unexpected.dart';
import 'package:somnio_firebase_authentication/src/exceptions/user_disabled.dart';
import 'package:somnio_firebase_authentication/src/exceptions/user_not_found.dart';
import 'package:somnio_firebase_authentication/src/exceptions/weak_password.dart';
import 'package:somnio_firebase_authentication/src/exceptions/wrong_password.dart';
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
    try {
      return _firebaseAuth.currentUser;
    } on Exception catch (_) {
      throw UnexpectedException();
    }
  }

  @override
  Future<User> signInAnonymously() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      return userCredential.user;
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'operation-not-allowed') {
        throw OperationNotAllowedException(
          code: 'sia_operation_not_allowed',
          message: 'This operation is not allowed',
        );
      }
      throw UnexpectedException();
    }
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case 'invalid-email':
          throw InvalidEmailException(
            code: 'siweap_invalid_email',
            message: 'Invalid email',
          );
          break;
        case 'user-disabled':
          throw UserDisabledException(
            code: 'siweap_user_disabled',
            message: 'This user is disabled',
          );
          break;
        case 'user-not-found':
          throw UserNotFoundException(
            code: 'siweap_user_not_found',
            message: 'A user corresponding to the given email does not exist',
          );
          break;
        case 'wrong-password':
          throw WrongPasswordException(
            code: 'siweap_wrong_password',
            message: 'Wrong password',
          );
          break;
        default:
          throw UnexpectedException();
          break;
      }
    }
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
    } on FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case 'email-already-in-use':
          throw EmailInUseException(
            code: 'cuweap_email_already_in_use',
            message: 'An user for this email already exists',
          );
          break;
        case 'invalid-email':
          throw InvalidEmailException(
            code: 'cuweap_invalid_email',
            message: 'Invalid email',
          );
          break;
        case 'operation-not-allowed':
          throw OperationNotAllowedException(
            code: 'cuweap_operation_not_allowed',
            message: 'Operation not allowed',
          );
          break;
        case 'weak-password':
          throw WeakPasswordException(
            code: 'cuweap_weak_password',
            message: 'The password is too weak',
          );
          break;
        default:
          throw UnexpectedException();
          break;
      }
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on Exception {
      throw UnexpectedException();
    }
  }

  Future<User> _signInWithAService(SignInService service) async {
    final firebaseCredential = await service.getFirebaseCredential();
    if (firebaseCredential != null) {
      try {
        final userCredential = await _firebaseAuth.signInWithCredential(
          firebaseCredential,
        );
        _signInMethod = service;
        return userCredential.user;
      } on FirebaseAuthException catch (exception) {
        switch (exception.code) {
          case 'invalid-credential':
            throw InvalidCredentialException(
              code: 'siwas_invalid_credential',
              message: 'Invalid credential',
            );
            break;
          case 'operation-not-allowed':
            throw OperationNotAllowedException(
              code: 'siwas_operation_not_allowed',
              message: 'Operation not allowed',
            );
            break;
          case 'user-disabled':
            throw UserDisabledException(
              code: 'siwas_user_disabled',
              message: 'This user is disabled',
            );
            break;
          case 'user-not-found':
            throw UserNotFoundException(
              code: 'siwas_user_not_found',
              message:
                  'A user corresponding to the given credential does not exist',
            );
            break;
          case 'wrong-password':
            throw WrongPasswordException(
              code: 'siwas_wrong_password',
              message: 'Wrong password',
            );
            break;
          default:
            throw UnexpectedException();
            break;
        }
      }
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
    try {
      await _signInMethod?.signOut();
      _signInMethod = null;
      await _firebaseAuth.signOut();
    } on Exception {
      throw UnexpectedException();
    }
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
    } on Exception {
      throw UnexpectedException();
    }
  }

  @override
  Future<bool> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      await user.delete();
      return true;
    } on FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case 'requires-recent-login':
          throw RequiresRecentLoginException(
            code: 'da_requires_recent_login',
            message: 'Requires recent login',
          );
          break;
        default:
          throw UnexpectedException();
          break;
      }
    }
  }
}
