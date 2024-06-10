import 'package:api_fake_storage_orm/src/data/api/product/errors/product_exception.dart';
import 'package:api_fake_storage_orm/src/domain/models/product.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProductUseCase {
  final ProductRepository productRepository;

  UpdateProductUseCase(this.productRepository);

  Future<Either<ProductApiException, Product>> call(Product product) => productRepository.updateProduct(product);

}
