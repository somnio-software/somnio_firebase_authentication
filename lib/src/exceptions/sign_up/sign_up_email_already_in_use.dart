import 'package:somnio_firebase_authentication/src/exceptions/sign_up/sign_up.dart';

class SignUpEmailInUseException implements SignUpException {
  String code = 'cuweap_email_already_in_use';
  String message;

  SignUpEmailInUseException({required this.message});
}
