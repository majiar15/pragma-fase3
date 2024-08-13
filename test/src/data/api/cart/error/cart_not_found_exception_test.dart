import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_not_found_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartNotFoundException', () {
      const message = 'error message';

    test('should create an CartNotFoundException with a given message', () {
      final exception = CartNotFoundException(message);

      expect(exception.message, message);
    });

    test('toString should return the correct format', () {
      final exception = CartNotFoundException(message);

      expect(exception.toString(), 'CartApiException: $message');
    });
  });
}
