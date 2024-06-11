import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:api_fake_storage_orm/src/domain/models/cart.dart';
import 'package:dartz/dartz.dart';

import '../models/user.dart';

abstract class CartRepository {

  Future<Either<CartApiException, List<Cart>>> getAllCarts(Sort? sort, int? limit);
  Future<Either<CartApiException, Cart>> getCartById(int cartId);
  Future<Either<CartApiException, Cart>> getCartByUserId(int userId);
  Future<Either<CartApiException, int>> addCart(int userId, List<ProductCart> products);
  Future<Either<CartApiException, int>> updateProductsCart(int cartId, int userId, List<ProductCart> products);
  Future<Either<CartApiException, Cart>> deleteCart(int cartId);

}
