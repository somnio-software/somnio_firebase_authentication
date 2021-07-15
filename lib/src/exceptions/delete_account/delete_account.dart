class DeleteAccountException implements Exception {
  String code;
  String message;

  DeleteAccountException({this.code, this.message});
}
