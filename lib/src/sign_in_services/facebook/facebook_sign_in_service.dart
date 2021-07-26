import 'package:firebase_auth/firebase_auth.dart' as Auth;
import '../sign_in_service.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInService implements SignInService {
  FacebookAuth? _parameterInstance;

  FacebookSignInService({FacebookAuth? signInMethod}) {
    _parameterInstance = signInMethod;
  }

  FacebookAuth _generateFacebookAuthInstance() {
    return _parameterInstance ?? FacebookAuth.instance;
  }

  Future<LoginResult> _facebookSignIn() {
    final facebookAuthInstance = _generateFacebookAuthInstance();
    return facebookAuthInstance.login(
      loginBehavior: LoginBehavior.nativeWithFallback,
    );
  }

  Auth.OAuthCredential _createFirebaseCredential(String facebookToken) {
    return Auth.FacebookAuthProvider.credential(facebookToken);
  }

  @override
  Future<Auth.OAuthCredential?> getFirebaseCredential() async {
    final result = await _facebookSignIn();
    switch (result.status) {
      case LoginStatus.success:
        final accessToken = result.accessToken!.token;
        return _createFirebaseCredential(accessToken);
      case LoginStatus.cancelled:
        return null;
      case LoginStatus.failed:
        throw Auth.FirebaseAuthException(
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: result.message,
        );
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> signOut() async {
    final facebookAuthInstance = _generateFacebookAuthInstance();
    await facebookAuthInstance.logOut();
  }
}
