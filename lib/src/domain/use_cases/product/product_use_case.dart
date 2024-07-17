import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:api_fake_storage_orm/src/data/api/product/errors/product_exception.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';

class ProductUseCase {
  final ProductRepository _productRepository;

  ProductUseCase(this._productRepository);

  Future<Either<ProductApiException, ProductModel>> addProduct(ProductModel product) => _productRepository.addProduct(product);

  Future<Either<ProductApiException, ProductModel>> deleteProduct(int productId) => _productRepository.deleteProduct(productId);

  Future<Either<ProductApiException, List<ProductModel>>> getAll(Sort? sort, int? limit) => _productRepository.getAllProducts(sort, limit);

  Future<Either<ProductApiException, List<ProductModel>>> getByCategory(String category) => _productRepository.getProductByCategory(category);

  Future<Either<ProductApiException, ProductModel>> getOne(int id) => _productRepository.getProductById(id);

  Future<Either<ProductApiException, ProductModel>> updateProduct(ProductModel product) => _productRepository.updateProduct(product);

}
