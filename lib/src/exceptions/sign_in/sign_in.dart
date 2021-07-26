class SignInException implements Exception {
  String code;
  String message;

  SignInException({required this.code, required this.message});
}
