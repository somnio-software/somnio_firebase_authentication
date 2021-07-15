class SignInException implements Exception {
  String code;
  String message;

  SignInException({this.code, this.message});
}
