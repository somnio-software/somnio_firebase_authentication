import 'package:somnio_firebase_authentication/src/exceptions/credentials/credentials.dart';

class CredentialsUserDisabledException implements CredentialsException {
  String code = 'siwas_user_disabled';
  String message;

  CredentialsUserDisabledException({this.message});
}
