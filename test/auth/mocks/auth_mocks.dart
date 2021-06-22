import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:somnio_firebase_authentication/somnio_firebase_authentication.dart';
import 'package:somnio_firebase_authentication/src/sign_in_services/apple/apple_credentials.dart';
import 'package:somnio_firebase_authentication/src/sign_in_services/apple/apple_sign_in_service.dart';
import 'package:somnio_firebase_authentication/src/sign_in_services/facebook/facebook_sign_in_service.dart';
import 'package:somnio_firebase_authentication/src/sign_in_services/google/google_sign_in_service.dart';

class MockFirebaseAuth extends Mock implements Auth.FirebaseAuth {}

class MockAuthService extends Mock implements AuthService {}

class MockFirebaseAuthService extends Mock implements FirebaseAuthService {}

class MockFirebaseUser extends Mock implements Auth.User {}

class MockUserCredential extends Mock implements Auth.UserCredential {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockGoogleSignInService extends Mock implements GoogleSignInService {}

class MockFacebookLogin extends Mock implements FacebookAuth {}

class MockFacebookLoginResult extends Mock implements LoginResult {}

class MockFacebookAccessToken extends Mock implements AccessToken {}

class MockFacebookSignInService extends Mock implements FacebookSignInService {}

class MockAppleSignInService extends Mock implements AppleSignInService {}

class MockAppleCredentials extends Mock implements AppleCredentials {}
