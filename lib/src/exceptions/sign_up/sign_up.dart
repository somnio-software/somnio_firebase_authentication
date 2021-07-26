class SignUpException implements Exception {
  String code;
  String message;

  SignUpException({required this.code, required this.message});
}
