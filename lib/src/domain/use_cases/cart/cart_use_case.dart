import 'package:api_fake_store_orm/api_fake_store_orm.dart';
import 'package:dartz/dartz.dart';

import 'package:api_fake_store_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart' show ProductCartApi, CartApiModel;

import 'package:api_fake_store_orm/src/domain/repositories/cart_repository.dart';

class CartUseCase {
  final CartRepository _cartRepository;

  CartUseCase(this._cartRepository);

  Future<Either<CartApiException, int>> addCart(int userId, List<ProductCartApi> products) =>
      _cartRepository.addCart(userId,products);

  Future<Either<CartApiException, CartApiModel>> deleteCart(int cartId) =>
      _cartRepository.deleteCart(cartId);

  Future<Either<CartApiException, List<CartApiModel>>> getAll(Sort? sort, int? limit) =>
      _cartRepository.getAllCarts(sort, limit);

  Future<Either<CartApiException, CartApiModel>> getCartByUser(int userId) =>
      _cartRepository.getCartByUserId(userId);

  Future<Either<CartApiException, CartApiModel>> getOne(int cartId) =>
      _cartRepository.getCartById(cartId);

  Future<Either<CartApiException, int>> updateCart(
    int cartId,
    int userId,
    List<ProductCartApi> products,
  ) =>
      _cartRepository.updateProductsCart(cartId, userId, products);
}
