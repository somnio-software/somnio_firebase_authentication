class UserNotFoundException implements Exception {
  String code;
  String message;

  UserNotFoundException({this.code, this.message});
}
