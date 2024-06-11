import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/cart_api.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:api_fake_storage_orm/src/domain/models/cart_model.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/cart_repository.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/cart/cart_use_case.dart';


class CartManager {
  final CartRepository _cartRepository = CartApi();

  late final CartUseCase _cartUseCase;

  CartManager() {
    _cartUseCase = CartUseCase(_cartRepository);
  }

  Future<List<CartModel>> getAll({Sort? sort, int? limit}) async {
    final cartEither = await _cartUseCase.getAll(sort, limit);
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }

  Future<CartModel> getOne(int cartId) async {
    final cartEither = await _cartUseCase.getOne(cartId);
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }

  Future<CartModel> getOneByUser(int userId) async {
    final cartEither = await _cartUseCase.getCartByUser(userId);
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }

  Future<int> create(int userId, List<ProductCart> products) async {
    final cartEither = await _cartUseCase.addCart(userId, products);
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }

  Future<CartModel> delete(int cartId) async {
    final cartEither = await _cartUseCase.deleteCart(cartId);
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }

  Future<int> update(
    int cartId,
    int userId,
    List<ProductCart> products,
  ) async {
    final cartEither = await _cartUseCase.updateCart(
      cartId,
      userId,
      products,
    );
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }
}
