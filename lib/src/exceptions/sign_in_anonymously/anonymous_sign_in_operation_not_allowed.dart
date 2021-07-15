import 'package:somnio_firebase_authentication/src/exceptions/sign_in_anonymously/anonymous_sign_in.dart';

class SignInAnonymouslyOperationNotAllowedException
    implements AnonymousSignInException {
  String code = 'sia_operation_not_allowed';
  String message;

  SignInAnonymouslyOperationNotAllowedException({this.message});
}
