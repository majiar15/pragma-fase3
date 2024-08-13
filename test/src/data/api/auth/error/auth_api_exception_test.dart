import 'package:flutter_test/flutter_test.dart';
import 'package:api_fake_storage_orm/src/data/api/auth/error/auth_exception.dart';

void main() {
  group('AuthApiException', () {
      const message = 'error message';

    test('should create an AuthApiException with a given message', () {
      final exception = AuthApiException(message);

      expect(exception.message, message);
      expect(exception.toString(), 'AuthApiException: $message');
    });

    test('toString should return the correct format', () {
      final exception = AuthApiException(message);

      expect(exception.toString(), 'AuthApiException: $message');
    });
  });
}
