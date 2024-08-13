import 'package:api_fake_storage_orm/src/data/api/product/errors/product_not_found_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductNotFoundException', () {
      const message = 'error message';

    test('should create an ProductNotFoundException with a given message', () {
      final exception = ProductNotFoundException(message);

      expect(exception.message, message);
    });

    test('toString should return the correct format', () {
      final exception = ProductNotFoundException(message);

      expect(exception.toString(), 'ProductApiException: $message');
    });
  });
}
