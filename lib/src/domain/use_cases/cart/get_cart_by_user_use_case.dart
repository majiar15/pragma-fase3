import 'package:api_fake_storage_orm/src/domain/models/cart.dart';
import 'package:dartz/dartz.dart';

import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/cart_repository.dart';

class GetCartByUserUseCase {
  final CartRepository cartRepository;

  GetCartByUserUseCase(this.cartRepository);

  Future<Either<CartApiException, Cart>> call(int userId) =>
      cartRepository.getCartByUserId(userId);
}
