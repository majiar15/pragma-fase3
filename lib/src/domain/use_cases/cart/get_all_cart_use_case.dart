import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:api_fake_storage_orm/src/domain/models/cart.dart';
import 'package:dartz/dartz.dart';

import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/cart_repository.dart';

class GetAllCartUseCase {
  final CartRepository cartRepository;

  GetAllCartUseCase(this.cartRepository);

  Future<Either<CartApiException, List<Cart>>> call(Sort? sort, int? limit) =>
      cartRepository.getAllCarts(sort, limit);
}
