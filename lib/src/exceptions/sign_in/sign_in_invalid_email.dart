import 'package:somnio_firebase_authentication/src/exceptions/sign_in/sign_in.dart';

class SignInInvalidEmailException implements SignInException {
  String code = 'siweap_invalid_email';
  String message;

  SignInInvalidEmailException({required this.message});
}
