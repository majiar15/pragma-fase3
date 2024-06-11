import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:dartz/dartz.dart';

import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:api_fake_storage_orm/src/domain/models/cart_model.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/cart_repository.dart';

class CartUseCase {
  final CartRepository _cartRepository;

  CartUseCase(this._cartRepository);

  Future<Either<CartApiException, int>> addCart(int userId, List<ProductCart> products) =>
      _cartRepository.addCart(userId,products);

  Future<Either<CartApiException, CartModel>> deleteCart(int cartId) =>
      _cartRepository.deleteCart(cartId);

  Future<Either<CartApiException, List<CartModel>>> getAll(Sort? sort, int? limit) =>
      _cartRepository.getAllCarts(sort, limit);

  Future<Either<CartApiException, CartModel>> getCartByUser(int userId) =>
      _cartRepository.getCartByUserId(userId);

  Future<Either<CartApiException, CartModel>> getOne(int cartId) =>
      _cartRepository.getCartById(cartId);

  Future<Either<CartApiException, int>> updateCart(
    int cartId,
    int userId,
    List<ProductCart> products,
  ) =>
      _cartRepository.updateProductsCart(cartId, userId, products);
}
