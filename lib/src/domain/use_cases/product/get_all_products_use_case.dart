



import 'package:api_fake_storage_orm/src/data/api/product/errors/product_exception.dart';
import 'package:api_fake_storage_orm/src/domain/models/product.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllProductsUseCase {

  final ProductRepository productRepository;

  GetAllProductsUseCase(this.productRepository);

  Future<Either<ProductApiException, List<Product>>> call() => productRepository.getAllProducts();

}
