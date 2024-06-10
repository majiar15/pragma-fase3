import 'package:dartz/dartz.dart';

import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:api_fake_storage_orm/src/domain/models/cart.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/cart_repository.dart';

class AddCartUseCase {
  final CartRepository cartRepository;

  AddCartUseCase(this.cartRepository);

  Future<Either<CartApiException, int>> call(int userId, List<ProductCart> products) =>
      cartRepository.addCart(userId,products);
}
