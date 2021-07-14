class EmailInUseException implements Exception {
  String code;
  String message;

  EmailInUseException({this.code, this.message});
}
