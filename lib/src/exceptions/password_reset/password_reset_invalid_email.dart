import 'package:somnio_firebase_authentication/src/exceptions/password_reset/password_reset.dart';

class PasswordResetInvalidEmailException implements PasswordResetException {
  String code = 'spre_invalid_email';
  String message;

  PasswordResetInvalidEmailException({this.message});
}
