import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/cart_repository.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart' show ProductCartApi, CartApiModel;

import 'cart_repository_test.mocks.dart';


@GenerateMocks([CartRepository])
void main() {
  late CartRepository mockCartRepository;
  CartApiModel cart = CartApiModel(userId: 1, products: [], date: DateTime.now(), id: 1, v: 0);
  setUp(() {
    mockCartRepository = MockCartRepository();
  });

  group('getAllCarts', () {
    test('debería devolver una lista de CartApiModel cuando la llamada sea exitosa', () async {
      final cartList = [cart];
      when(mockCartRepository.getAllCarts(null, null))
          .thenAnswer((_) async => Right(cartList));

      final result = await mockCartRepository.getAllCarts(null, null);

      expect(result, Right(cartList));
    });

    test('debería devolver un CartApiException cuando la llamada falle', () async {
      final failure = CartApiException('Error inesperado');
      when(mockCartRepository.getAllCarts(null, null))
          .thenAnswer((_) async => Left(failure));

      final result = await mockCartRepository.getAllCarts(null, null);

      expect(result, Left(failure));
    });
  });

  group('getCartById', () {
    test('debería devolver un CartApiModel cuando la llamada sea exitosa', () async {
      when(mockCartRepository.getCartById(1))
          .thenAnswer((_) async => Right(cart));

      final result = await mockCartRepository.getCartById(1);

      expect(result, Right(cart));
    });

    test('debería devolver un CartApiException cuando la llamada falle', () async {
      final failure = CartApiException('Error inesperado');
      when(mockCartRepository.getCartById(1))
          .thenAnswer((_) async => Left(failure));

      final result = await mockCartRepository.getCartById(1);

      expect(result, Left(failure));
    });
  });

  group('getCartByUserId', () {
    test('debería devolver un CartApiModel cuando la llamada sea exitosa', () async {
      when(mockCartRepository.getCartByUserId(1))
          .thenAnswer((_) async => Right(cart));

      final result = await mockCartRepository.getCartByUserId(1);

      expect(result, Right(cart));
    });

    test('debería devolver un CartApiException cuando la llamada falle', () async {
      final failure = CartApiException('Error inesperado');
      when(mockCartRepository.getCartByUserId(1))
          .thenAnswer((_) async => Left(failure));

      final result = await mockCartRepository.getCartByUserId(1);

      expect(result, Left(failure));
    });
  });

  group('addCart', () {
    test('debería devolver un ID de carrito cuando la llamada sea exitosa', () async {
      final products = <ProductCartApi>[];
      final cartId = 1;
      when(mockCartRepository.addCart(1, products))
          .thenAnswer((_) async => Right(cartId));

      final result = await mockCartRepository.addCart(1, products);

      expect(result, Right(cartId));
    });

    test('debería devolver un CartApiException cuando la llamada falle', () async {
      final products = <ProductCartApi>[];
      final failure = CartApiException('Error inesperado');
      when(mockCartRepository.addCart(1, products))
          .thenAnswer((_) async => Left(failure));

      final result = await mockCartRepository.addCart(1, products);

      expect(result, Left(failure));
    });
  });

  group('updateProductsCart', () {
    test('debería devolver un ID de carrito cuando la llamada sea exitosa', () async {
      final products = <ProductCartApi>[];
      final cartId = 1;
      when(mockCartRepository.updateProductsCart(cartId, 1, products))
          .thenAnswer((_) async => Right(cartId));

      final result = await mockCartRepository.updateProductsCart(cartId, 1, products);

      expect(result, Right(cartId));
    });

    test('debería devolver un CartApiException cuando la llamada falle', () async {
      final products = <ProductCartApi>[];
      final failure = CartApiException('Error inesperado');
      when(mockCartRepository.updateProductsCart(1, 1, products))
          .thenAnswer((_) async => Left(failure));

      final result = await mockCartRepository.updateProductsCart(1, 1, products);

      expect(result, Left(failure));
    });
  });

  group('deleteCart', () {
    test('debería devolver un CartApiModel cuando la llamada sea exitosa', () async {
      when(mockCartRepository.deleteCart(1))
          .thenAnswer((_) async => Right(cart));

      final result = await mockCartRepository.deleteCart(1);

      expect(result, Right(cart));
    });

    test('debería devolver un CartApiException cuando la llamada falle', () async {
      final failure = CartApiException('Error inesperado');
      when(mockCartRepository.deleteCart(1))
          .thenAnswer((_) async => Left(failure));

      final result = await mockCartRepository.deleteCart(1);

      expect(result, Left(failure));
    });
  });
}
