import 'package:api_fake_storage_orm/src/data/api/category/error/category_exception.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'category_repository_test.mocks.dart';


@GenerateMocks([CategoryRepository])
void main() {
  late CategoryRepository mockRepository;

  setUp(() {
    mockRepository = MockCategoryRepository();
  });

  group('getAllCategories', () {
    test('debería devolver una lista de categorías cuando la llamada sea exitosa', () async {
      final categories = ['Electronics', 'Clothing', 'Books'];
      when(mockRepository.getAllCategories())
          .thenAnswer((_) async => Right(categories));

      final result = await mockRepository.getAllCategories();

      expect(result, Right(categories));
    });

    test('debería lanzar un CategoryApiException cuando la llamada falle', () async {
      final exception = CategoryApiException('Error al obtener categorías');
      when(mockRepository.getAllCategories())
          .thenAnswer((_) async => Left(exception));

      final result = await mockRepository.getAllCategories();

      expect(result, Left(exception));
    });
  });
}
