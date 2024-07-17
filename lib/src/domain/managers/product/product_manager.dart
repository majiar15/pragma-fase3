import 'package:flutter_models_commons/flutter_models_commons.dart';
import 'package:dartz/dartz.dart';
import 'package:api_fake_store_orm/src/common/enum/sort.dart';
import 'package:api_fake_store_orm/src/data/api/product/errors/product_exception.dart';
import 'package:api_fake_store_orm/src/data/api/product/product_api.dart';
import 'package:api_fake_store_orm/src/domain/repositories/product_repository.dart';
import 'package:api_fake_store_orm/src/domain/use_cases/product/product_use_case.dart';

class ProductManager {
  final ProductRepository _productRepository = ProductApi();
  late final ProductUseCase _productUseCase;


  ProductManager() {
    _productUseCase = ProductUseCase(_productRepository);
  }

  Future<List<ProductModel>> getAll({Sort? sort, int? limit}) async {
    final productsEither = await _productUseCase.getAll(sort, limit);
    return productsEither.fold((l) => throw ProductApiException(l.message), (r) => r);
  }

  Future<ProductModel> getOne(int productId) async {
    final productsEither = await _productUseCase.getOne(productId);
    return productsEither.fold((l) => throw ProductApiException(l.message), (r) => r);
  }

  Future<List<ProductModel>> getByCategory(String category) async {
    final productsEither = await _productUseCase.getByCategory(category);
    return productsEither.fold((l) => throw ProductApiException(l.message), (r) => r);
  }
  Future<ProductModel> create(ProductModel product) async {
    final productsEither = await _productUseCase.addProduct(product);
    return productsEither.fold((l) => throw ProductApiException(l.message), (r) => r);
  }

  Future<ProductModel> delete(int productId) async {
    final productsEither = await _productUseCase.deleteProduct(productId);
    return productsEither.fold((l) => throw ProductApiException(l.message), (r) => r);
  }

  Future<ProductModel> update(ProductModel product) async {
    final productsEither = await _productUseCase.updateProduct(product);
    return productsEither.fold((l) => throw ProductApiException(l.message), (r) => r);
  }

}
