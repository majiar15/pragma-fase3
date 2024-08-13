import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:api_fake_storage_orm/src/domain/managers/cart/cart_manager.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/cart/cart_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_manager_test.mocks.dart';

@GenerateMocks([CartUseCase])
void main() {
  late CartManager cartManager;
  late MockCartUseCase mockCartUseCase;
  final cartModel = CartApiModel(id: 1, products: [], userId: 1, date: DateTime.now(), v: 0);
  final cartModels = [cartModel];

  setUp(() {
    mockCartUseCase = MockCartUseCase();
    cartManager = CartManager(mockCartUseCase);
  });

  group('CartManager', () {
    test('debería devolver una lista de Carros cuando getAll sea exitoso', () async {
      when(mockCartUseCase.getAll(null, null))
          .thenAnswer((_) async => Right(cartModels));

      final result = await cartManager.getAll();

      expect(result, cartModels);
    });

    test('debería lanzar una CartApiException cuando getAll falle', () async {
      final exception = CartApiException('Error al obtener los carritos');
      when(mockCartUseCase.getAll(null, null))
          .thenAnswer((_) async => Left(exception));

      expect(() async => await cartManager.getAll(),
          throwsA(isA<CartApiException>()));
    });

    test('debería devolver un CartApiModel cuando getOne sea exitoso', () async {
      when(mockCartUseCase.getOne(1))
          .thenAnswer((_) async => Right(cartModel));

      final result = await cartManager.getOne(1);

      expect(result, cartModel);
    });

    test('debería lanzar una CartApiException cuando getOne falle', () async {
      final exception = CartApiException('Error al obtener el carrito');
      when(mockCartUseCase.getOne(1))
          .thenAnswer((_) async => Left(exception));

      expect(() async => await cartManager.getOne(1),
          throwsA(isA<CartApiException>()));
    });

    test('debería devolver un CartApiModel cuando getOneByUser sea exitoso', () async {
      when(mockCartUseCase.getCartByUser(1))
          .thenAnswer((_) async => Right(cartModel));

      final result = await cartManager.getOneByUser(1);

      expect(result, cartModel);
    });

    test('debería lanzar una CartApiException cuando getOneByUser falle', () async {
      final exception = CartApiException('Error al obtener el carrito del usuario');
      when(mockCartUseCase.getCartByUser(1))
          .thenAnswer((_) async => Left(exception));

      expect(() async => await cartManager.getOneByUser(1),
          throwsA(isA<CartApiException>()));
    });

    test('debería devolver un ID cuando create sea exitoso', () async {
      const userId = 1;
      final products = <ProductCartApi>[];
      const cartId = 2;
      when(mockCartUseCase.addCart(userId, products))
          .thenAnswer((_) async => const Right(cartId));

      final result = await cartManager.create(userId, products);

      expect(result, cartId);
    });

    test('debería lanzar una CartApiException cuando create falle', () async {
      const userId = 1;
      final products = <ProductCartApi>[];
      final exception = CartApiException('Error al crear el carrito');
      when(mockCartUseCase.addCart(userId, products))
          .thenAnswer((_) async => Left(exception));

      expect(() async => await cartManager.create(userId, products),
          throwsA(isA<CartApiException>()));
    });

    test('debería devolver un CartApiModel cuando delete sea exitoso', () async {
      when(mockCartUseCase.deleteCart(1))
          .thenAnswer((_) async => Right(cartModel));

      final result = await cartManager.delete(1);

      expect(result, cartModel);
    });

    test('debería lanzar una CartApiException cuando delete falle', () async {
      final exception = CartApiException('Error al eliminar el carrito');
      when(mockCartUseCase.deleteCart(1))
          .thenAnswer((_) async => Left(exception));

      expect(() async => await cartManager.delete(1),
          throwsA(isA<CartApiException>()));
    });

    test('debería devolver un ID cuando update sea exitoso', () async {
      const cartId = 1;
      const userId = 2;
      final products = <ProductCartApi>[];
      const updatedCartId = 3;
      when(mockCartUseCase.updateCart(cartId, userId, products))
          .thenAnswer((_) async => const Right(updatedCartId));

      final result = await cartManager.update(cartId, userId, products);

      expect(result, updatedCartId);
    });

    test('debería lanzar una CartApiException cuando update falle', () async {
      const cartId = 1;
      const userId = 2;
      final products = <ProductCartApi>[];
      final exception = CartApiException('Error al actualizar el carrito');
      when(mockCartUseCase.updateCart(cartId, userId, products))
          .thenAnswer((_) async => Left(exception));

      expect(() async => await cartManager.update(cartId, userId, products),
          throwsA(isA<CartApiException>()));
    });
  });
}
