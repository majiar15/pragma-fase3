import 'package:api_fake_store_orm/api_fake_store_orm.dart';
import 'package:api_fake_store_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart' show ProductCartApi, CartApiModel;
import 'package:dartz/dartz.dart';


abstract class CartRepository {

  Future<Either<CartApiException, List<CartApiModel>>> getAllCarts(Sort? sort, int? limit);
  Future<Either<CartApiException, CartApiModel>> getCartById(int cartId);
  Future<Either<CartApiException, CartApiModel>> getCartByUserId(int userId);
  Future<Either<CartApiException, int>> addCart(int userId, List<ProductCartApi> products);
  Future<Either<CartApiException, int>> updateProductsCart(int cartId, int userId, List<ProductCartApi> products);
  Future<Either<CartApiException, CartApiModel>> deleteCart(int cartId);

}
