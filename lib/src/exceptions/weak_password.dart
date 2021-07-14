class WeakPasswordException implements Exception {
  String code;
  String message;

  WeakPasswordException({this.code, this.message});
}
