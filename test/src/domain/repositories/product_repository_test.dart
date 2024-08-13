import 'package:api_fake_storage_orm/src/common/enum/sort.dart';
import 'package:api_fake_storage_orm/src/data/api/product/errors/product_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/product_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_repository_test.mocks.dart';


@GenerateMocks([ProductRepository])
void main() {
  late ProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
  });

  group('ProductRepository', () {
    final product = ProductModel(id: 1, title: 'Test Product', price: 99.99, description: 'Test description', category: 'Test category', image: 'image_url', rating: Rating(rate: 4.5, count: 100));
    final productList = [product];

    test('debería devolver una lista de productos cuando la llamada a getAllProducts sea exitosa', () async {
      when(mockRepository.getAllProducts(Sort.asc, 10))
          .thenAnswer((_) async => Right(productList));

      final result = await mockRepository.getAllProducts(Sort.asc, 10);

      expect(result, Right(productList));
    });

    test('debería devolver un producto cuando la llamada a getProductById sea exitosa', () async {
      when(mockRepository.getProductById(1))
          .thenAnswer((_) async => Right(product));

      final result = await mockRepository.getProductById(1);

      expect(result, Right(product));
    });

    test('debería devolver una lista de productos cuando la llamada a getProductByCategory sea exitosa', () async {
      when(mockRepository.getProductByCategory('Test category'))
          .thenAnswer((_) async => Right(productList));

      final result = await mockRepository.getProductByCategory('Test category');

      expect(result, Right(productList));
    });

    test('debería devolver un ProductModel cuando la llamada a addProduct sea exitosa', () async {
      when(mockRepository.addProduct(product))
          .thenAnswer((_) async => Right(product));

      final result = await mockRepository.addProduct(product);

      expect(result, Right(product));
    });

    test('debería devolver un ProductModel cuando la llamada a updateProduct sea exitosa', () async {
      when(mockRepository.updateProduct(product))
          .thenAnswer((_) async => Right(product));

      final result = await mockRepository.updateProduct(product);

      expect(result, Right(product));
    });

    test('debería devolver un ProductModel cuando la llamada a deleteProduct sea exitosa', () async {
      when(mockRepository.deleteProduct(1))
          .thenAnswer((_) async => Right(product));

      final result = await mockRepository.deleteProduct(1);

      expect(result, Right(product));
    });

    test('debería lanzar un ProductApiException cuando la llamada falle', () async {
      final exception = ProductApiException('Error al obtener productos');
      when(mockRepository.getAllProducts(Sort.asc, 10))
          .thenAnswer((_) async => Left(exception));

      final result = await mockRepository.getAllProducts(Sort.asc, 10);

      expect(result, Left(exception));
    });
  });
}
