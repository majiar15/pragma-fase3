import 'package:flutter_test/flutter_test.dart';
import 'package:api_fake_storage_orm/src/common/config/environment.dart';

void main() {
  group('Environment', () {
    test('apiUrl should be correct', () {
      expect(Environment.apiUrl, 'https://fakestoreapi.com');
    });
  });
}
