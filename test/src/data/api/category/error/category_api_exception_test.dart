import 'package:api_fake_storage_orm/src/data/api/category/error/category_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryApiException', () {
      const message = 'error message';

    test('should create an CategoryApiException with a given message', () {
      final exception = CategoryApiException(message);

      expect(exception.message, message);
    });

    test('toString should return the correct format', () {
      final exception = CategoryApiException(message);

      expect(exception.toString(), 'CategoryApiException: $message');
    });
  });
}
