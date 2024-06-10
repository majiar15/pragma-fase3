import 'package:dartz/dartz.dart';

import 'package:api_fake_storage_orm/src/domain/models/cart.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/cart_repository.dart';

class UpdateCartUseCase {
  final CartRepository cartRepository;

  UpdateCartUseCase(this.cartRepository);

  Future<Either<CartApiException, int>> call(
    int cartId,
    int userId,
    List<ProductCart> products,
  ) =>
      cartRepository.updateProductsCart(cartId, userId, products);
}
