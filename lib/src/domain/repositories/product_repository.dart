
import 'package:api_fake_storage_orm/src/common/enum/sort.dart';
import 'package:api_fake_storage_orm/src/data/api/product/errors/product_exception.dart';
import 'package:dartz/dartz.dart';

import '../models/product_model.dart';

abstract class ProductRepository {

  Future<Either<ProductApiException, List<ProductModel>>> getAllProducts(Sort? sort, int? limit);
  Future<Either<ProductApiException, ProductModel>> getProductById(int productId);
  Future<Either<ProductApiException, List<ProductModel>>> getProductByCategory(String category);
  Future<Either<ProductApiException, ProductModel>> addProduct(ProductModel product);
  Future<Either<ProductApiException, ProductModel>> updateProduct(ProductModel product);
  Future<Either<ProductApiException, ProductModel>> deleteProduct(int productId);

}