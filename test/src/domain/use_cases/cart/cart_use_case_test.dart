import 'package:api_fake_storage_orm/src/domain/use_cases/cart/cart_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../repositories/cart_repository_test.mocks.dart';


void main() {
  late CartUseCase cartUseCase;
  late MockCartRepository mockCartRepository;
  const userId = 1;
  final products = <ProductCartApi>[];
  final cart = CartApiModel(userId: userId, products: products, id: 1, date: DateTime.now(), v: 0);

  setUp(() {
    mockCartRepository = MockCartRepository();
    cartUseCase = CartUseCase(mockCartRepository);
  });

  group('CartUseCase', () {
    const cartId = 1;
    final products = <ProductCartApi>[];

    test('debería añadir un carrito correctamente', () async {
      when(mockCartRepository.addCart(userId, products))
          .thenAnswer((_) async => const Right(cartId));

      final result = await cartUseCase.addCart(userId, products);


      expect(result.fold((l) => l, (r) => r), cartId);
    });

    test('debería eliminar un carrito correctamente', () async {

      when(mockCartRepository.deleteCart(cartId))
          .thenAnswer((_) async => Right(cart));


      final result = await cartUseCase.deleteCart(cartId);


      expect(result.fold((l) => l, (r) => r), cart);
    });

    test('debería obtener todos los carritos correctamente', () async {
      final cartList = <CartApiModel>[];


      when(mockCartRepository.getAllCarts(null, null))
          .thenAnswer((_) async => Right(cartList));


      final result = await cartUseCase.getAll(null, null);


      expect(result.fold((l) => l, (r) => r), cartList);
    });

    test('debería obtener un carrito por ID correctamente', () async {


      when(mockCartRepository.getCartById(cartId))
          .thenAnswer((_) async => Right(cart));


      final result = await cartUseCase.getOne(cartId);


      expect(result.fold((l) => l, (r) => r), cart);
    });

    test('debería obtener un carrito por ID de usuario correctamente', () async {


      when(mockCartRepository.getCartByUserId(userId))
          .thenAnswer((_) async => Right(cart));


      final result = await cartUseCase.getCartByUser(userId);


      expect(result.fold((l) => l, (r) => r), cart);
    });

    test('debería actualizar un carrito correctamente', () async {

      when(mockCartRepository.updateProductsCart(cartId, userId, products))
          .thenAnswer((_) async => const Right(cartId));


      final result = await cartUseCase.updateCart(cartId, userId, products);


      expect(result.fold((l) => l, (r) => r), cartId);
    });
  });
}
