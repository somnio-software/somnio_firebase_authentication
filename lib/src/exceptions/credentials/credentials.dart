class CredentialsException implements Exception {
  String code;
  String message;

  CredentialsException({this.code, this.message});
}
