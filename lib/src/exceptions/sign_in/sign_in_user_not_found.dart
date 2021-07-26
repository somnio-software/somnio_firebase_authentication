import 'package:somnio_firebase_authentication/src/exceptions/sign_in/sign_in.dart';

class SignInUserNotFoundException implements SignInException {
  String code = 'siweap_user_not_found';
  String message;

  SignInUserNotFoundException({required this.message});
}
