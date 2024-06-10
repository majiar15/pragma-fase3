class CategoryApiException implements Exception {
  final String message;
  CategoryApiException(this.message);

  @override
  String toString() => 'CategoryApiException: $message';
}