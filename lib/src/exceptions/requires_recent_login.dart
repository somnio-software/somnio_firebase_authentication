class RequiresRecentLoginException implements Exception {
  String code;
  String message;

  RequiresRecentLoginException({this.code, this.message});
}
