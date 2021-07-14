class UnexpectedException implements Exception {
  final String code = 'unexpected_error';
  final String message = 'An unexpected error occurred';

  UnexpectedException();
}
