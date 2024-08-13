import 'package:api_fake_storage_orm/src/data/api/cart/cart_api.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';
import 'package:flutter_models_commons/flutter_models_commons.dart' show ProductCartApi, CartApiModel;

@GenerateMocks([http.Client])
import 'cart_api_test.mocks.dart';
void main() {
  group('CartApi', () {
    final mockClient = MockClient();
    final cartApi = CartApi(client: mockClient);

    test('addCart when the request is successful', () async {
      final products = [
        ProductCartApi(productId: 1, quantity: 2)
      ];
      final responseBody = jsonEncode({"id": 1});
      when(mockClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(responseBody, 200));

      final result = await cartApi.addCart(1, products);

      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r), 1);
    });

    test('addCart when the request is fails', () async {
      final products = [
        ProductCartApi(productId: 1, quantity: 2)
      ];
      when(mockClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Error', 400));

      final result = await cartApi.addCart(1, products);

      expect(result.isLeft(), true);

      expect(result.fold((l) => l, (r) => r), isA<CartApiException>());

    });
    test('deleteCart when the request is successful', () async {
      final responseBody = jsonEncode({
        "id": 1,
        "userId": 1,
        "date": "2023-07-14T00:00:00.000Z",
        "products": [
          {"productId": 1, "quantity": 2}
        ],
        "__v": 0
      });
      when(mockClient.delete(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(responseBody, 200));

      final result = await cartApi.deleteCart(1);

      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r), isA<CartApiModel>());

    });

    test('deleteCart when the request fails', () async {
      when(mockClient.delete(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Error', 400));

      final result = await cartApi.deleteCart(1);

      expect(result.isLeft(), true);

      expect(result.fold((l) => l, (r) => r), isA<CartApiException>());
    });

    test('getAllCarts when the request is successful', () async {
      final responseBody = jsonEncode([
        {
          "id": 1,
          "userId": 1,
          "date": "2023-07-14T00:00:00.000Z",
          "products": [
            {"productId": 1, "quantity": 2}
          ],
          "__v": 0
        }
      ]);
      when(mockClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(responseBody, 200));

      final result = await cartApi.getAllCarts(null, null);

      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r), isA<List<CartApiModel>>());
    });


    
    test('getCartById when the request is successful', () async {
      final responseBody = jsonEncode({
        "id": 1,
        "userId": 1,
        "date": "2023-07-14T00:00:00.000Z",
        "products": [
          {"productId": 1, "quantity": 2}
        ],
        "__v": 0
      });
      when(mockClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(responseBody, 200));

      final result = await cartApi.getCartById(1);

      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r), isA<CartApiModel>());

    });

    test('getCartById  when the request fails', () async {
      when(mockClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Error', 400));

      final result = await cartApi.getCartById(1);

      expect(result.isLeft(), true);
    });

    test('getCartByUserId when the request is successful', () async {
      final responseBody = jsonEncode([
        {
          "id": 1,
          "userId": 1,
          "date": "2023-07-14T00:00:00.000Z",
          "products": [
            {"productId": 1, "quantity": 2}
          ],
        "__v": 0
        }
      ]);
      when(mockClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(responseBody, 200));

      final result = await cartApi.getCartByUserId(1);

      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r), isA<CartApiModel>());

    });

    test('getCartByUserId when the request fails', () async {
      when(mockClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Error', 400));

      final result = await cartApi.getCartByUserId(1);

      expect(result.isLeft(), true);
    });

    
    test('updateProductsCart  when the request is successful', () async {
      final products = [
        ProductCartApi(productId: 1, quantity: 2)
      ];
      final responseBody = jsonEncode({"id": 1});
      when(mockClient.put(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(responseBody, 200));

      final result = await cartApi.updateProductsCart(1, 1, products);

      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r), 1);
    });

    test('updateProductsCart when the request fails', () async {
      final products = [
        ProductCartApi(productId: 1, quantity: 2)
      ];
      when(mockClient.put(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Error', 400));

      final result = await cartApi.updateProductsCart(1, 1, products);

      expect(result.isLeft(), true);
    });
  });
}
