import 'package:somnio_firebase_authentication/src/exceptions/sign_up/sign_up.dart';

class SignUpInvalidEmailException implements SignUpException {
  String code = 'cuweap_invalid_email';
  String message;

  SignUpInvalidEmailException({this.message});
}
