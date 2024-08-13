import 'package:api_fake_storage_orm/src/data/api/product/errors/product_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductApiException', () {
      const message = 'error message';

    test('should create an ProductApiException with a given message', () {
      final exception = ProductApiException(message);

      expect(exception.message, message);
    });

    test('toString should return the correct format', () {
      final exception = ProductApiException(message);

      expect(exception.toString(), 'ProductApiException: $message');
    });
  });
}
