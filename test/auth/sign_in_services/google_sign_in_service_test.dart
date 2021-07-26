import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:somnio_firebase_authentication/src/sign_in_services/google/google_sign_in_service.dart';
import 'package:somnio_firebase_authentication/src/sign_in_services/sign_in_service.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;

import 'google_sign_in_service_test.mocks.dart';

@GenerateMocks([
  GoogleSignIn,
  GoogleSignInAccount,
  GoogleSignInAuthentication,
])
void main() async {
  group('Google Sign in service /', () {
    GoogleSignIn? _googleSignIn;
    GoogleSignInAccount? _googleAccount;
    GoogleSignInAuthentication? _googleAuth;
    SignInService? _googleSignInService;

    setUp(() {
      _googleSignIn = MockGoogleSignIn();
      _googleAccount = MockGoogleSignInAccount();
      _googleAuth = MockGoogleSignInAuthentication();
      _googleSignInService = GoogleSignInService(signInMethod: _googleSignIn);
    });

    test('Success', () async {
      final credential = Auth.GoogleAuthProvider.credential(
        idToken: 'abcd1234',
        accessToken: 'abcd1234',
      );

      when(_googleSignIn!.signIn()).thenAnswer((_) async => _googleAccount);

      when(_googleAccount!.authentication)
          .thenAnswer((_) async => _googleAuth!);

      when(_googleAuth!.accessToken).thenReturn(credential.accessToken);

      when(_googleAuth!.idToken).thenReturn(credential.idToken);

      final obtainedCredential =
          await _googleSignInService!.getFirebaseCredential();

      expect(obtainedCredential!.accessToken, credential.accessToken);
      expect(obtainedCredential.idToken, credential.idToken);
    });

    test('Cancelled by user', () async {
      when(_googleSignIn!.signIn()).thenAnswer((_) async => null);

      expect(await _googleSignInService!.getFirebaseCredential(), null);
    });

    test('No google auth', () async {
      when(_googleSignIn!.signIn()).thenAnswer((_) async => _googleAccount);

      when(_googleAccount!.authentication)
          .thenAnswer((_) async => _googleAuth!);

      when(_googleAuth!.accessToken).thenReturn(null);

      when(_googleAuth!.idToken).thenReturn(null);

      expect(() async => _googleSignInService!.getFirebaseCredential(),
          throwsException);
    });
  });
}
