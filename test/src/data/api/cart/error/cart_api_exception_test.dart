import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartApiException', () {
      const message = 'error message';

    test('should create an CartApiException with a given message', () {
      final exception = CartApiException(message);

      expect(exception.message, message);
    });

    test('toString should return the correct format', () {
      final exception = CartApiException(message);

      expect(exception.toString(), 'CartApiException: $message');
    });
  });
}
