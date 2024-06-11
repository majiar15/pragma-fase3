
import 'package:api_fake_storage_orm/src/common/enum/sort.dart';
import 'package:api_fake_storage_orm/src/data/api/product/errors/product_exception.dart';
import 'package:dartz/dartz.dart';

import '../models/product.dart';

abstract class ProductRepository {

  Future<Either<ProductApiException, List<Product>>> getAllProducts(Sort? sort, int? limit);
  Future<Either<ProductApiException, Product>> getProductById(int productId);
  Future<Either<ProductApiException, List<Product>>> getProductByCategory(String category);
  Future<Either<ProductApiException, Product>> addProduct(Product product);
  Future<Either<ProductApiException, Product>> updateProduct(Product product);
  Future<Either<ProductApiException, Product>> deleteProduct(int productId);

}