class NoClothesException implements Exception {
  final String message;

  NoClothesException(this.message);

  @override
  String toString() {
    return 'ValidationException: $message';
  }
}
