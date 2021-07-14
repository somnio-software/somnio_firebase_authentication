class WrongPasswordException implements Exception {
  String code;
  String message;

  WrongPasswordException({this.code, this.message});
}
