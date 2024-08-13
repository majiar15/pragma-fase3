import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:api_fake_storage_orm/src/data/api/product/product_api.dart';
import 'package:api_fake_storage_orm/src/data/api/product/errors/product_exception.dart';
import 'package:api_fake_storage_orm/src/data/api/product/errors/product_not_found_exception.dart';
import 'package:api_fake_storage_orm/src/common/config/environment.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';

import 'product_api_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  late ProductApi productApi;
  late MockClient mockClient;

  final products = [
    ProductModel(
      id: 1,
      title: 'Product 1',
      price: 100,
      category: "category 1",
      description: "description 1",
      image: "new image 1",
      rating: Rating(rate: 0.0, count: 0)
    ),
    ProductModel(
      id: 2,
      title: 'Product 2',
      price: 100,
      category: "category 2",
      description: "description 2",
      image: "new image 2",
      rating: Rating(rate: 0.0, count: 0)
    )
  ];
  final product = ProductModel(
    id: 1,
    title: 'Product 1',
    price: 100,
    category: "category 1",
    description: "description 1",
    image: "new image 1",
    rating: Rating(rate: 0.0, count: 0)
  );

  setUp(() {
    mockClient = MockClient();
    productApi = ProductApi(client: mockClient);
  });

  group('ProductApi', () {
    test('getAllProducts returns list of products on success', () async {


      when(mockClient.get(
        Uri.parse('${Environment.apiUrl}/products'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response(jsonEncode(products), 200));

      final result = await productApi.getAllProducts(null, null);

      expect(result, isA<Right>());
      expect(result.fold((l) => l, (r) => r), isA<List<ProductModel>>());

    });

    test('getAllProducts returns ProductNotFoundException on failure', () async {
      when(mockClient.get(
        Uri.parse('${Environment.apiUrl}/products'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response('Not Found', 404));

      final result = await productApi.getAllProducts(null, null);

      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<ProductNotFoundException>()),
        (r) => fail('Expected a Left but got a Right'),
      );
    });

    test('getProductById returns product on success', () async {
      when(mockClient.get(
        Uri.parse('${Environment.apiUrl}/products/1'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response(jsonEncode(product), 200));

      final result = await productApi.getProductById(1);

      expect(result, isA<Right>());
      expect(result.fold((l) => l, (r) => r.id), product.id);
      expect(result.fold((l) => l, (r) => r.title), product.title);

    });

    test('getProductById returns ProductNotFoundException on failure', () async {
      when(mockClient.get(
        Uri.parse('${Environment.apiUrl}/products/1'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response('Not Found', 404));

      final result = await productApi.getProductById(1);

      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<ProductNotFoundException>()),
        (r) => fail('Expected a Left but got a Right'),
      );
    });

    test('addProduct returns added product on success', () async {
      when(mockClient.post(
        Uri.parse('${Environment.apiUrl}/products'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product),
      )).thenAnswer((_) async => http.Response(jsonEncode(product), 200));

      final result = await productApi.addProduct(product);

      expect(result, isA<Right>());
      expect(result.fold((l) => l, (r) => r.id), product.id);
      expect(result.fold((l) => l, (r) => r.title), product.title);

    });

    test('addProduct returns ProductApiException on failure', () async {

      when(mockClient.post(
        Uri.parse('${Environment.apiUrl}/products'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product),
      )).thenAnswer((_) async => http.Response('Error', 500));

      final result = await productApi.addProduct(product);

      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<ProductApiException>()),
        (r) => fail('Expected a Left but got a Right'),
      );
    });

    test('deleteProduct returns deleted product on success', () async {

      when(mockClient.delete(
        Uri.parse('${Environment.apiUrl}/products/1'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response(jsonEncode(product), 200));

      final result = await productApi.deleteProduct(1);

      expect(result, isA<Right>());
      expect(result.fold((l) => l, (r) => r.id), product.id);
      expect(result.fold((l) => l, (r) => r.title), product.title);

    });

    test('deleteProduct returns ProductApiException on failure', () async {
      when(mockClient.delete(
        Uri.parse('${Environment.apiUrl}/products/1'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response('Error', 500));

      final result = await productApi.deleteProduct(1);

      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<ProductApiException>()),
        (r) => fail('Expected a Left but got a Right'),
      );
    });

    test('getProductByCategory returns list of products on success', () async {

      when(mockClient.get(
        Uri.parse('${Environment.apiUrl}/products/category/category1'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response(jsonEncode(products), 200));

      final result = await productApi.getProductByCategory('category1');

      expect(result, isA<Right>());
      expect(result.fold((l) => l, (r) => r), isA<List<ProductModel>>());

    });

    test('getProductByCategory returns ProductNotFoundException on failure', () async {
      when(mockClient.get(
        Uri.parse('${Environment.apiUrl}/products/category/category1'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response('Not Found', 404));

      final result = await productApi.getProductByCategory('category1');

      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<ProductNotFoundException>()),
        (r) => fail('Expected a Left but got a Right'),
      );
    });

    test('updateProduct returns updated product on success', () async {

      when(mockClient.put(
        Uri.parse('${Environment.apiUrl}/products/1'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product),
      )).thenAnswer((_) async => http.Response(jsonEncode(product), 200));

      final result = await productApi.updateProduct(product);

      expect(result, isA<Right>());
      expect(result.fold((l) => l, (r) => r.id), product.id);
      expect(result.fold((l) => l, (r) => r.title), product.title);
    });

    test('updateProduct returns ProductApiException on failure', () async {

      when(mockClient.put(
        Uri.parse('${Environment.apiUrl}/products/1'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product),
      )).thenAnswer((_) async => http.Response('Error', 500));

      final result = await productApi.updateProduct(product);

      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<ProductApiException>()),
        (r) => fail('Expected a Left but got a Right'),
      );
    });
  });
}
