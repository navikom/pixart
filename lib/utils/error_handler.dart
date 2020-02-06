class ErrorHandler implements Exception {
  final String message;

  ErrorHandler(this.message);

  @override
  String toString() {
    return 'Exception: $message';
  }
}
