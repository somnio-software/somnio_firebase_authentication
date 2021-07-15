import 'package:somnio_firebase_authentication/src/exceptions/credentials/credentials.dart';

class CredentialsWrongPasswordException implements CredentialsException {
  String code = 'siwas_wrong_password';
  String message;

  CredentialsWrongPasswordException({this.message});
}
