class DeleteAccountException implements Exception {
  String code;
  String message;

  DeleteAccountException({required this.code, required this.message});
}
