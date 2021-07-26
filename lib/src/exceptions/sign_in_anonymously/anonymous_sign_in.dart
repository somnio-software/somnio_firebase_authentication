class AnonymousSignInException implements Exception {
  String code;
  String message;

  AnonymousSignInException({required this.code, required this.message});
}
