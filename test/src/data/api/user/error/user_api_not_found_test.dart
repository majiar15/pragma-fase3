import 'package:api_fake_storage_orm/src/data/api/user/error/user_not_found_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserNotFoundException', () {
      const message = 'error message';

    test('should create an UserNotFoundException with a given message', () {
      final exception = UserNotFoundException(message);

      expect(exception.message, message);
    });

    test('toString should return the correct format', () {
      final exception = UserNotFoundException(message);

      expect(exception.toString(), 'UserApiException: $message');
    });
  });
}
