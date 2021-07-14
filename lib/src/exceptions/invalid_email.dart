class InvalidEmailException implements Exception {
  String code;
  String message;

  InvalidEmailException({this.code, this.message});
}
