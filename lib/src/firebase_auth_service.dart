import 'package:firebase_auth/firebase_auth.dart';
import 'package:somnio_firebase_authentication/src/exceptions/credentials/credentials_operation_not_allowed.dart';
import 'package:somnio_firebase_authentication/src/exceptions/credentials/credentials_user_disabled.dart';
import 'package:somnio_firebase_authentication/src/exceptions/credentials/credentials_user_not_found.dart';
import 'package:somnio_firebase_authentication/src/exceptions/credentials/credentials_wrong_password.dart';
import 'package:somnio_firebase_authentication/src/exceptions/password_reset/password_reset_invalid_email.dart';
import 'package:somnio_firebase_authentication/src/exceptions/password_reset/password_reset_user_not_found.dart';
import 'package:somnio_firebase_authentication/src/exceptions/sign_in_anonymously/anonymous_sign_in_operation_not_allowed.dart';
import 'package:somnio_firebase_authentication/src/exceptions/sign_up/sign_up_email_already_in_use.dart';
import 'package:somnio_firebase_authentication/src/exceptions/credentials/credentials_invalid_credential.dart';
import 'package:somnio_firebase_authentication/src/exceptions/sign_in/sign_in_invalid_email.dart';
import 'package:somnio_firebase_authentication/src/exceptions/sign_in/sign_in_operation_not_allowed.dart';
import 'package:somnio_firebase_authentication/src/exceptions/delete_account/delete_account_requires_recent_login.dart';
import 'package:somnio_firebase_authentication/src/exceptions/sign_up/sign_up_operation_not_allowed.dart';
import 'package:somnio_firebase_authentication/src/exceptions/sign_up/sign_up_invalid_email.dart';
import 'package:somnio_firebase_authentication/src/exceptions/unexpected.dart';
import 'package:somnio_firebase_authentication/src/exceptions/sign_in/sign_in_user_disabled.dart';
import 'package:somnio_firebase_authentication/src/exceptions/sign_in/sign_in_user_not_found.dart';
import 'package:somnio_firebase_authentication/src/exceptions/sign_up/sign_up_weak_password.dart';
import 'package:somnio_firebase_authentication/src/exceptions/sign_in/sign_in_wrong_password.dart';
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
        throw SignInAnonymouslyOperationNotAllowedException(
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
          throw SignInInvalidEmailException(
            message: 'Invalid email',
          );
          break;
        case 'user-disabled':
          throw SignInUserDisabledException(
            message: 'This user is disabled',
          );
          break;
        case 'user-not-found':
          throw SignInUserNotFoundException(
            message: 'A user corresponding to the given email does not exist',
          );
          break;
        case 'wrong-password':
          throw SignInWrongPasswordException(
            message: 'Wrong password',
          );
          break;
        case 'operation-not-allowed':
          throw SignInOperationNotAllowedException(
            message: 'Operation not allowed',
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
          throw SignUpEmailInUseException(
            message: 'An user for this email already exists',
          );
          break;
        case 'invalid-email':
          throw SignUpInvalidEmailException(
            message: 'Invalid email',
          );
          break;
        case 'operation-not-allowed':
          throw SignUpOperationNotAllowedException(
            message: 'Operation not allowed',
          );
          break;
        case 'weak-password':
          throw SignUpWeakPasswordException(
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
    } on FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case 'user-not-found':
          throw PasswordResetUserNotFoundException(
            message: 'There is no user corresponding to the given email',
          );
          break;
        case 'invalid-email':
          throw PasswordResetInvalidEmailException(
            message: 'Invalid email',
          );
          break;
        default:
          throw UnexpectedException();
          break;
      }
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
            throw CredentialsInvalidException(
              message: 'Invalid credential',
            );
            break;
          case 'operation-not-allowed':
            throw CredentialsOperationNotAllowedException(
              message: 'Operation not allowed',
            );
            break;
          case 'user-disabled':
            throw CredentialsUserDisabledException(
              message: 'This user is disabled',
            );
            break;
          case 'user-not-found':
            throw CredentialsUserNotFoundException(
              message:
                  'A user corresponding to the given credential does not exist',
            );
            break;
          case 'wrong-password':
            throw CredentialsWrongPasswordException(
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
          throw DeleteAccountRequiresRecentLoginException(
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
