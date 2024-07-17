
import 'package:api_fake_store_orm/src/data/api/category/category_api.dart';
import 'package:api_fake_store_orm/src/data/api/category/error/category_exception.dart';
import 'package:api_fake_store_orm/src/domain/repositories/category_repository.dart';
import 'package:api_fake_store_orm/src/domain/use_cases/category/category_use_case.dart';
import 'package:dartz/dartz.dart';

class CategoryManager {
  final CategoryRepository _categoryRepository = CategoryApi();
  late final CategoriesUseCase _categoriesUseCase;

  CategoryManager() {
    _categoriesUseCase = CategoriesUseCase(_categoryRepository);
  }

  Future<List<String>> getAll() async {
    final categoryEither = await _categoriesUseCase.getAll();
    return categoryEither.fold((l) => throw CategoryApiException(l.message), (r) => r);
  }

}
