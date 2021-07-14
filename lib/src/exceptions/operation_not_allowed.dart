class OperationNotAllowedException implements Exception {
  String code;
  String message;

  OperationNotAllowedException({this.code, this.message});
}
