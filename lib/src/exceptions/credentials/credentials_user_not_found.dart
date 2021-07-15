import 'package:somnio_firebase_authentication/src/exceptions/credentials/credentials.dart';

class CredentialsUserNotFoundException implements CredentialsException {
  String code = 'siwas_user_not_found';
  String message;

  CredentialsUserNotFoundException({this.message});
}
