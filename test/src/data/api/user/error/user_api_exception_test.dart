
import 'package:api_fake_storage_orm/src/data/api/user/error/user_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserApiException', () {
      const message = 'error message';

    test('should create an UserApiException with a given message', () {
      final exception = UserApiException(message);

      expect(exception.message, message);
    });

    test('toString should return the correct format', () {
      final exception = UserApiException(message);

      expect(exception.toString(), 'UserApiException: $message');
    });
  });
}
