import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:api_fake_storage_orm/src/domain/models/cart_model.dart';
import 'package:dartz/dartz.dart';


abstract class CartRepository {

  Future<Either<CartApiException, List<CartModel>>> getAllCarts(Sort? sort, int? limit);
  Future<Either<CartApiException, CartModel>> getCartById(int cartId);
  Future<Either<CartApiException, CartModel>> getCartByUserId(int userId);
  Future<Either<CartApiException, int>> addCart(int userId, List<ProductCart> products);
  Future<Either<CartApiException, int>> updateProductsCart(int cartId, int userId, List<ProductCart> products);
  Future<Either<CartApiException, CartModel>> deleteCart(int cartId);

}
