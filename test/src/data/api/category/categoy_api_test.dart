import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:api_fake_storage_orm/src/common/config/environment.dart';
import 'package:api_fake_storage_orm/src/data/api/category/category_api.dart';
import 'package:api_fake_storage_orm/src/data/api/category/error/category_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'categoy_api_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  group('CategoryApi', () {
    late CategoryApi categoryApi;
    late MockClient mockClient;
    final categories = ['electronics', 'jewelery', 'men\'s clothing', 'women\'s clothing'];

    setUp(() {
      mockClient = MockClient();
      categoryApi = CategoryApi(client: mockClient);
    });

    test('successful getAllCategories returns list of categories', () async {

      when(mockClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(categories), 200));

      final result = await categoryApi.getAllCategories();

      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r), categories);
    });

    test('failed getAllCategories returns CategoryApiException', () async {
      when(mockClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));

      final result = await categoryApi.getAllCategories();

      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<CategoryApiException>()),
        (r) => fail('Expected a Left but got a Right'),
      );
    });

    test('exception thrown returns CategoryApiException', () async {
      when(mockClient.get(
        Uri.parse('${Environment.apiUrl}/products/categories'),
        headers: anyNamed('headers'),
      )).thenThrow(Exception('Network Error'));

      final result = await categoryApi.getAllCategories();

      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<CategoryApiException>()),
        (r) => fail('Expected a Left but got a Right'),
      );
    });
  });
}
