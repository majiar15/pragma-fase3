import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/cart_api.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:api_fake_storage_orm/src/domain/models/cart.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/cart_repository.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/cart/add_cart_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/cart/delete_cart_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/cart/get_all_cart_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/cart/get_cart_by_user_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/cart/get_one_cart_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/cart/update_cart_use_case.dart';

class CartManager {
  final CartRepository _cartRepository = CartApi();

  late final GetAllCartUseCase _getAllCartsUseCase;
  late final GetOneCartUseCase _getOneCartUseCase;
  late final GetCartByUserUseCase _getCartByUserUseCase;
  late final AddCartUseCase _addCartUseCase;
  late final DeleteCartUseCase _deleteCartUseCase;
  late final UpdateCartUseCase _updateCartUseCase;

  CartManager() {
    _getAllCartsUseCase = GetAllCartUseCase(_cartRepository);
    _getOneCartUseCase = GetOneCartUseCase(_cartRepository);
    _getCartByUserUseCase = GetCartByUserUseCase(_cartRepository);
    _addCartUseCase = AddCartUseCase(_cartRepository);
    _deleteCartUseCase = DeleteCartUseCase(_cartRepository);
    _updateCartUseCase = UpdateCartUseCase(_cartRepository);
  }

  Future<List<Cart>> getAll({Sort? sort, int? limit}) async {
    final cartEither = await _getAllCartsUseCase(sort, limit);
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }

  Future<Cart> getOne(int cartId) async {
    final cartEither = await _getOneCartUseCase(cartId);
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }

  Future<Cart> getOneByUser(int userId) async {
    final cartEither = await _getCartByUserUseCase(userId);
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }

  Future<int> create(int userId, List<ProductCart> products) async {
    final cartEither = await _addCartUseCase(userId, products);
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }

  Future<Cart> delete(int cartId) async {
    final cartEither = await _deleteCartUseCase(cartId);
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }

  Future<int> update(
    int cartId,
    int userId,
    List<ProductCart> products,
  ) async {
    final cartEither = await _updateCartUseCase(
      cartId,
      userId,
      products,
    );
    return cartEither.fold((l) => throw CartApiException(l.message), (r) => r);
  }
}
