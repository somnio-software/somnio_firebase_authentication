import 'package:somnio_firebase_authentication/src/exceptions/sign_up/sign_up.dart';

class SignUpOperationNotAllowedException implements SignUpException {
  String code = 'cuweap_operation_not_allowed';
  String message;

  SignUpOperationNotAllowedException({required this.message});
}
