import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/cart_api.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart' show ProductCartApi, CartApiModel;
import 'package:api_fake_storage_orm/src/domain/repositories/cart_repository.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/cart/cart_use_case.dart';


class CartManager {
  final CartRepository _cartRepository = CartApi();

  late final CartUseCase _cartUseCase;

  CartManager() {
    _cartUseCase = CartUseCase(_cartRepository);
  }

  Future<List<CartApiModel>> getAll({Sort? sort, int? limit}) async {
    final cartEither = await _cartUseCase.getAll(sort, limit);
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }

  Future<CartApiModel> getOne(int cartId) async {
    final cartEither = await _cartUseCase.getOne(cartId);
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }

  Future<CartApiModel> getOneByUser(int userId) async {
    final cartEither = await _cartUseCase.getCartByUser(userId);
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }

  Future<int> create(int userId, List<ProductCartApi> products) async {
    final cartEither = await _cartUseCase.addCart(userId, products);
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }

  Future<CartApiModel> delete(int cartId) async {
    final cartEither = await _cartUseCase.deleteCart(cartId);
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }

  Future<int> update(
    int cartId,
    int userId,
    List<ProductCartApi> products,
  ) async {
    final cartEither = await _cartUseCase.updateCart(
      cartId,
      userId,
      products,
    );
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }
}
