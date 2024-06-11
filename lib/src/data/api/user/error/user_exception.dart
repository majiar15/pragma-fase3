class UserApiException implements Exception {
  final String message;
  UserApiException(this.message);

  @override
  String toString() => 'UserApiException: $message';
}