import 'package:api_fake_storage_orm/src/data/api/category/error/category_exception.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/category/category_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../repositories/category_repository_test.mocks.dart';

void main() {
  late CategoriesUseCase categoriesUseCase;
  late MockCategoryRepository mockCategoryRepository;

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    categoriesUseCase = CategoriesUseCase(mockCategoryRepository);
  });

  group('CategoriesUseCase', () {
    final categories = ['Electronics', 'Furniture', 'Clothing'];
    test('debería devolver una lista de categorías cuando la llamada sea exitosa', () async {

      when(mockCategoryRepository.getAllCategories())
          .thenAnswer((_) async => Right(categories));

      final result = await categoriesUseCase.getAll();

      expect(result.fold((l) => l, (r) => r), categories);
    });

    test('debería devolver un CategoryApiException cuando la llamada falle', () async {

      final exception = CategoryApiException('Error fetching categories');
      when(mockCategoryRepository.getAllCategories())
          .thenAnswer((_) async => Left(exception));


      final result = await categoriesUseCase.getAll();


      expect(result.fold((l) => l, (r) => r), exception);
    });
  });
}
