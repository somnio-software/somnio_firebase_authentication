import 'package:somnio_firebase_authentication/src/exceptions/sign_in/sign_in.dart';

class SignInWrongPasswordException implements SignInException {
  String code = 'siweap_wrong_password';
  String message;

  SignInWrongPasswordException({required this.message});
}
