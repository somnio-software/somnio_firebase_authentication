class SignUpException implements Exception {
  String code;
  String message;

  SignUpException({this.code, this.message});
}
