class PasswordResetException implements Exception {
  String code;
  String message;

  PasswordResetException({required this.code, required this.message});
}
