import 'package:somnio_firebase_authentication/src/exceptions/password_reset/password_reset.dart';

class PasswordResetUserNotFoundException implements PasswordResetException {
  String code = 'spre_user_not_found';
  String message;

  PasswordResetUserNotFoundException({required this.message});
}
