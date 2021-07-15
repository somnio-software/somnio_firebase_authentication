class AnonymousSignInException implements Exception {
  String code;
  String message;

  AnonymousSignInException({this.code, this.message});
}
