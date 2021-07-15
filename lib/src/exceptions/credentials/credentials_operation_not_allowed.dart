import 'package:somnio_firebase_authentication/src/exceptions/credentials/credentials.dart';

class CredentialsOperationNotAllowedException implements CredentialsException {
  String code = 'siwas_operation_not_allowed';
  String message;

  CredentialsOperationNotAllowedException({this.message});
}
