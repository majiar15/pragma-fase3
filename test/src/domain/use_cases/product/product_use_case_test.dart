
import 'package:api_fake_storage_orm/src/data/api/product/errors/product_exception.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/product/product_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../repositories/product_repository_test.mocks.dart';

void main() {
  late ProductUseCase productUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    productUseCase = ProductUseCase(mockProductRepository);
  });

  group('ProductUseCase', () {
    final product = ProductModel(
      id: 1,
      title: 'Test Product',
      price: 100.0,
      description: 'Test Description',
      image: 'http://example.com/image.png',
      category: 'Test Category',
      rating: Rating(count: 0,rate: 0)
    );

    test('debería agregar un producto y devolver el producto cuando la llamada sea exitosa', () async {
      when(mockProductRepository.addProduct(product))
          .thenAnswer((_) async => Right(product));

      final result = await productUseCase.addProduct(product);

      expect(result.fold((l) => l, (r) => r), product);
    });

    test('debería devolver un ProductApiException cuando agregar un producto falle', () async {
      final exception = ProductApiException('Error adding product');
      when(mockProductRepository.addProduct(product))
          .thenAnswer((_) async => Left(exception));

      final result = await productUseCase.addProduct(product);

      expect(result.fold((l) => l, (r) => r), exception);
    });

    test('debería eliminar un producto y devolver el producto eliminado cuando la llamada sea exitosa', () async {
      when(mockProductRepository.deleteProduct(1))
          .thenAnswer((_) async => Right(product));

      final result = await productUseCase.deleteProduct(1);

      expect(result.fold((l) => l, (r) => r), product);
    });

    test('debería devolver un ProductApiException cuando eliminar un producto falle', () async {
      final exception = ProductApiException('Error deleting product');
      when(mockProductRepository.deleteProduct(1))
          .thenAnswer((_) async => Left(exception));

      final result = await productUseCase.deleteProduct(1);

      expect(result.fold((l) => l, (r) => r), exception);
    });

    test('debería devolver una lista de productos cuando la llamada sea exitosa', () async {
      final products = [product];
      when(mockProductRepository.getAllProducts(null, null))
          .thenAnswer((_) async => Right(products));

      final result = await productUseCase.getAll(null, null);

      expect(result.fold((l) => l, (r) => r), products);
    });

    test('debería devolver un ProductApiException cuando obtener todos los productos falle', () async {
      final exception = ProductApiException('Error fetching products');
      when(mockProductRepository.getAllProducts(null, null))
          .thenAnswer((_) async => Left(exception));

      final result = await productUseCase.getAll(null, null);

      expect(result.fold((l) => l, (r) => r), exception);
    });

    test('debería devolver una lista de productos por categoría cuando la llamada sea exitosa', () async {
      final products = [product];
      when(mockProductRepository.getProductByCategory('Test Category'))
          .thenAnswer((_) async => Right(products));

      final result = await productUseCase.getByCategory('Test Category');

      expect(result.fold((l) => l, (r) => r), products);
    });

    test('debería devolver un ProductApiException cuando obtener productos por categoría falle', () async {
      final exception = ProductApiException('Error fetching products by category');
      when(mockProductRepository.getProductByCategory('Test Category'))
          .thenAnswer((_) async => Left(exception));

      final result = await productUseCase.getByCategory('Test Category');

      expect(result.fold((l) => l, (r) => r), exception);
    });

    test('debería devolver un producto cuando obtener un producto por ID sea exitoso', () async {
      when(mockProductRepository.getProductById(1))
          .thenAnswer((_) async => Right(product));

      final result = await productUseCase.getOne(1);

      expect(result.fold((l) => l, (r) => r), product);
    });

    test('debería devolver un ProductApiException cuando obtener un producto por ID falle', () async {
      final exception = ProductApiException('Error fetching product');
      when(mockProductRepository.getProductById(1))
          .thenAnswer((_) async => Left(exception));

      final result = await productUseCase.getOne(1);

      expect(result.fold((l) => l, (r) => r), exception);
    });

    test('debería actualizar un producto y devolver el producto actualizado cuando la llamada sea exitosa', () async {
      when(mockProductRepository.updateProduct(product))
          .thenAnswer((_) async => Right(product));

      final result = await productUseCase.updateProduct(product);

      expect(result.fold((l) => l, (r) => r), product);
    });

    test('debería devolver un ProductApiException cuando actualizar un producto falle', () async {
      final exception = ProductApiException('Error updating product');
      when(mockProductRepository.updateProduct(product))
          .thenAnswer((_) async => Left(exception));

      final result = await productUseCase.updateProduct(product);

      expect(result.fold((l) => l, (r) => r), exception);
    });
  });
}
