import 'package:somnio_firebase_authentication/src/exceptions/sign_up/sign_up.dart';

class SignUpWeakPasswordException implements SignUpException {
  String code = 'cuweap_weak_password';
  String message;

  SignUpWeakPasswordException({required this.message});
}
