
import 'package:dartz/dartz.dart';

import '../models/product.dart';

abstract class ProductRepository {

  Future<Either<String, List<Product>>> getAllProducts();
  Future<Either<String, Product>> getProductById(int productId);
  Future<Either<String, List<Product>>> getProductByCategory(String category);
  Future<Either<String, Product>> addProduct(Product product);
  Future<Either<String, Product>> updateProduct(Product product);
  Future<Either<String, Product>> deleteProduct(int productId);

}