import 'package:api_fake_storage_orm/src/data/api/category/error/category_exception.dart';
import 'package:api_fake_storage_orm/src/domain/managers/category/category_manager.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/category/category_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'category_manager_test.mocks.dart';

@GenerateMocks([CategoriesUseCase])
void main() {
  late CategoryManager categoryManager;
  late MockCategoriesUseCase mockCategoriesUseCase;

  setUp(() {
    mockCategoriesUseCase = MockCategoriesUseCase();
    categoryManager = CategoryManager(mockCategoriesUseCase);
  });

  group('CategoryManager', () {
    test('debería devolver una lista de categorías cuando getAll sea exitoso', () async {
      final categories = ['Electronics', 'Books'];
      when(mockCategoriesUseCase.getAll()).thenAnswer((_) async => Right(categories));

      final result = await categoryManager.getAll();

      expect(result, categories);
    });

    test('debería lanzar una CategoryApiException cuando getAll falle', () async {
      final exception = CategoryApiException('Error al obtener las categorías');
      when(mockCategoriesUseCase.getAll()).thenAnswer((_) async => Left(exception));

      expect(() async => await categoryManager.getAll(), throwsA(isA<CategoryApiException>()));
    });
  });
}
