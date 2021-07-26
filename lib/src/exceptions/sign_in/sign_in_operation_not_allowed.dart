import 'package:somnio_firebase_authentication/src/exceptions/sign_in/sign_in.dart';

class SignInOperationNotAllowedException implements SignInException {
  String code = 'siweap_operation_not_allowed';
  String message;

  SignInOperationNotAllowedException({required this.message});
}
