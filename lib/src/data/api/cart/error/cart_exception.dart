class CartApiException implements Exception {
  final String message;
  CartApiException(this.message);

  @override
  String toString() => 'CartApiException: $message';
}