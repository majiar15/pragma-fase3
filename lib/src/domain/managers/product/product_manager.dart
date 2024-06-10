import 'package:api_fake_storage_orm/src/data/api/product/errors/product_exception.dart';
import 'package:api_fake_storage_orm/src/data/api/product/product_api.dart';
import 'package:api_fake_storage_orm/src/domain/models/product.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/product_repository.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/product/add_product_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/product/delete_product_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/product/get_all_products_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/product/get_one_product_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/product/get_products_by_category_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/product/update_product_use_case.dart';
import 'package:dartz/dartz.dart';

class ProductManager {
  final ProductRepository _productRepository = ProductApi();
  late final GetAllProductsUseCase _getAllProductsUseCase;
  late final GetOneProductUseCase _getOneProductUseCase;
  late final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;

  late final AddProductUseCase _addProductUseCase;
  late final DeleteProductUseCase _deleteProductUseCase;
  late final UpdateProductUseCase _updateProductUseCase;

  ProductManager() {
    _getAllProductsUseCase = GetAllProductsUseCase(_productRepository);
    _getOneProductUseCase = GetOneProductUseCase(_productRepository);
    _getProductsByCategoryUseCase = GetProductsByCategoryUseCase(_productRepository);
    _addProductUseCase = AddProductUseCase(_productRepository);
    _deleteProductUseCase = DeleteProductUseCase(_productRepository);
    _updateProductUseCase = UpdateProductUseCase(_productRepository);
  }

  Future<List<Product>> getAll() async {
    final productsEither = await _getAllProductsUseCase();
    return productsEither.fold((l) => throw ProductApiException(l.message), (r) => r);
  }

  Future<Product> getOne(int userId) async {
    final productsEither = await _getOneProductUseCase(userId);
    return productsEither.fold((l) => throw ProductApiException(l.message), (r) => r);
  }

  Future<List<Product>> getByCategory(String category) async {
    final productsEither = await _getProductsByCategoryUseCase(category);
    return productsEither.fold((l) => throw ProductApiException(l.message), (r) => r);
  }
  Future<Product> create(Product product) async {
    final productsEither = await _addProductUseCase(product);
    return productsEither.fold((l) => throw ProductApiException(l.message), (r) => r);
  }

  Future<Product> delete(int productId) async {
    final productsEither = await _deleteProductUseCase(productId);
    return productsEither.fold((l) => throw ProductApiException(l.message), (r) => r);
  }

  Future<Product> update(Product product) async {
    final productsEither = await _updateProductUseCase(product);
    return productsEither.fold((l) => throw ProductApiException(l.message), (r) => r);
  }

}
