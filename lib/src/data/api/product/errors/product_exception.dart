class ProductApiException implements Exception {

  final String message;
  ProductApiException(this.message);

  @override
  String toString() => 'ProductApiException: $message';
}