class UserDisabledException implements Exception {
  String code;
  String message;

  UserDisabledException({this.code, this.message});
}
