class InvalidCredentialException implements Exception {
  String code;
  String message;

  InvalidCredentialException({this.code, this.message});
}
