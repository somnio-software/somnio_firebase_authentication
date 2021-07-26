class CredentialsException implements Exception {
  String code;
  String message;

  CredentialsException({required this.code, required this.message});
}
