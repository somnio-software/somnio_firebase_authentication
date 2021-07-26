import 'package:somnio_firebase_authentication/src/exceptions/delete_account/delete_account.dart';

class DeleteAccountRequiresRecentLoginException
    implements DeleteAccountException {
  String code = 'da_requires_recent_login';
  String message;

  DeleteAccountRequiresRecentLoginException({required this.message});
}
