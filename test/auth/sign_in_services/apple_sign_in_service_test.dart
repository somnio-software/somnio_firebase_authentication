import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:somnio_firebase_authentication/src/sign_in_services/apple/apple_credentials.dart';
import 'package:somnio_firebase_authentication/src/sign_in_services/apple/apple_sign_in_service.dart';
import 'package:mockito/mockito.dart';
import 'apple_sign_in_service_test.mocks.dart';

@GenerateMocks([
  AppleCredentials,
])
void main() {
  group('Apple sign in service /', () {
    AppleSignInService? _appleSignInService;
    AppleCredentials? _appleCredentials;

    setUp(() {
      _appleCredentials = MockAppleCredentials();
      _appleSignInService = AppleSignInService(signInMethod: _appleCredentials);
    });

    test('Success', () async {
      final credential = AuthorizationCredentialAppleID(
        userIdentifier: 'userIdentifier',
        givenName: 'givenName',
        familyName: 'familyName',
        authorizationCode: 'authorizationCode',
        email: 'email',
        identityToken: 'identityToken',
        state: 'state',
      );

      when(_appleCredentials!.getAppleCredentials([
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ], 'abcd1234'))
          .thenAnswer((_) async => credential);

      final obtainedCredential = await _appleSignInService!
          .getFirebaseCredential(testingNonce: 'abcd1234');

      expect(obtainedCredential!.idToken, credential.identityToken);
      expect(obtainedCredential.rawNonce, 'abcd1234');
    });

    test('Cancelled by user', () async {
      when(_appleCredentials!.getAppleCredentials([
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ], 'abcd1234'))
          .thenAnswer((_) async => null);

      expect(
          await _appleSignInService!
              .getFirebaseCredential(testingNonce: 'abcd1234'),
          null);
    });
  });
}
