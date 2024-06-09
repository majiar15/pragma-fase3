import 'package:api_fake_storage_orm/src/domain/models/cart.dart';
import 'package:dartz/dartz.dart';

import '../models/user.dart';

abstract class CartRepository {

  Future<Either<String, List<Cart>>> getAllCarts();
  Future<Either<String, Cart>> getCartById(int cartId);
  Future<Either<String, Cart>> getCartByUserId(int userId);
  Future<Either<String, Cart>> addCart(int userId, List<Product> products);
  Future<Either<String, Cart>> updateProductsCart(int cartId, int userId, List<Product> products);
  Future<Either<String, Cart>> deleteCart(int cartId);

}
