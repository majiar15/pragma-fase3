import 'package:api_fake_storage_orm/src/data/api/product/errors/product_exception.dart';
import 'package:api_fake_storage_orm/src/domain/managers/product/product_manager.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/product/product_use_case.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'product_manager_test.mocks.dart';


@GenerateMocks([ProductUseCase])
void main() {
  late ProductManager productManager;
  late MockProductUseCase mockProductUseCase;
  final products = [
    ProductModel(
      id: 1,
      title: 'Product 1',
      price: 100,
      category: "category 1",
      description: "description 1",
      image: "new image 1",
      rating: Rating(rate: 0.0, count: 0)
    ),
    ProductModel(
      id: 2,
      title: 'Product 2',
      price: 100,
      category: "category 2",
      description: "description 2",
      image: "new image 2",
      rating: Rating(rate: 0.0, count: 0)
    )
  ];
  final product = ProductModel(
    id: 1,
    title: 'Product 1',
    price: 100,
    category: "category 1",
    description: "description 1",
    image: "new image 1",
    rating: Rating(rate: 0.0, count: 0)
  );

  setUp(() {
    mockProductUseCase = MockProductUseCase();
    productManager = ProductManager(mockProductUseCase);
  });

  group('ProductManager', () {
    test('debería devolver una lista de productos cuando getAll sea exitoso', () async {
      when(mockProductUseCase.getAll(any, any)).thenAnswer((_) async => Right(products));

      final result = await productManager.getAll();

      expect(result, products);
    });

    test('debería lanzar una ProductApiException cuando getAll falle', () async {
      final exception = ProductApiException('Error al obtener los productos');
      when(mockProductUseCase.getAll(any, any)).thenAnswer((_) async => Left(exception));

      expect(() async => await productManager.getAll(), throwsA(isA<ProductApiException>()));
    });

    test('debería devolver un producto cuando getOne sea exitoso', () async {
      when(mockProductUseCase.getOne(any)).thenAnswer((_) async => Right(product));

      final result = await productManager.getOne(1);

      expect(result, product);
    });

    test('debería lanzar una ProductApiException cuando getOne falle', () async {
      final exception = ProductApiException('Error al obtener el producto');
      when(mockProductUseCase.getOne(any)).thenAnswer((_) async => Left(exception));

      expect(() async => await productManager.getOne(1), throwsA(isA<ProductApiException>()));
    });

    test('debería devolver una lista de productos cuando getByCategory sea exitoso', () async {
      when(mockProductUseCase.getByCategory(any)).thenAnswer((_) async => Right(products));

      final result = await productManager.getByCategory('Electronics');

      expect(result, products);
    });

    test('debería lanzar una ProductApiException cuando getByCategory falle', () async {
      final exception = ProductApiException('Error al obtener los productos por categoría');
      when(mockProductUseCase.getByCategory(any)).thenAnswer((_) async => Left(exception));

      expect(() async => await productManager.getByCategory('Electronics'), throwsA(isA<ProductApiException>()));
    });

    test('debería crear un producto cuando create sea exitoso', () async {
      when(mockProductUseCase.addProduct(any)).thenAnswer((_) async => Right(product));

      final result = await productManager.create(product);

      expect(result, product);
    });

    test('debería lanzar una ProductApiException cuando create falle', () async {
      final exception = ProductApiException('Error al crear el producto');
      when(mockProductUseCase.addProduct(any)).thenAnswer((_) async => Left(exception));

      expect(() async => await productManager.create(product), throwsA(isA<ProductApiException>()));
    });

    test('debería eliminar un producto cuando delete sea exitoso', () async {
      when(mockProductUseCase.deleteProduct(any)).thenAnswer((_) async => Right(product));

      final result = await productManager.delete(1);

      expect(result, product);
    });

    test('debería lanzar una ProductApiException cuando delete falle', () async {
      final exception = ProductApiException('Error al eliminar el producto');
      when(mockProductUseCase.deleteProduct(any)).thenAnswer((_) async => Left(exception));

      expect(() async => await productManager.delete(1), throwsA(isA<ProductApiException>()));
    });

    test('debería actualizar un producto cuando update sea exitoso', () async {

      when(mockProductUseCase.updateProduct(any)).thenAnswer((_) async => Right(product));

      final result = await productManager.update(product);

      expect(result, product);
    });

    test('debería lanzar una ProductApiException cuando update falle', () async {
      final exception = ProductApiException('Error al actualizar el producto');
      when(mockProductUseCase.updateProduct(any)).thenAnswer((_) async => Left(exception));

      expect(() async => await productManager.update(product), throwsA(isA<ProductApiException>()));
    });
  });
}
