import 'package:somnio_firebase_authentication/src/exceptions/credentials/credentials.dart';

class CredentialsInvalidException implements CredentialsException {
  String code = 'siwas_invalid_credential';
  String message;

  CredentialsInvalidException({this.message});
}
