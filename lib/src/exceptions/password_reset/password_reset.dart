class PasswordResetException implements Exception {
  String code;
  String message;

  PasswordResetException({this.code, this.message});
}
