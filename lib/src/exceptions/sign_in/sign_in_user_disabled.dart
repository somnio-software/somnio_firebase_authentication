import 'package:somnio_firebase_authentication/src/exceptions/sign_in/sign_in.dart';

class SignInUserDisabledException implements SignInException {
  String code = 'siweap_user_disabled';
  String message;

  SignInUserDisabledException({this.message});
}
