
import 'package:api_fake_storage_orm/src/data/api/category/category_api.dart';
import 'package:api_fake_storage_orm/src/data/api/category/error/category_exception.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/category_repository.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/category/get_all_category.dart';
import 'package:dartz/dartz.dart';

class CategoryManager {
  final CategoryRepository _categoryRepository = CategoryApi();
  late final GetAllCategoriesUseCase _getAllCategoriesUseCase;

  CategoryManager() {
    _getAllCategoriesUseCase = GetAllCategoriesUseCase(_categoryRepository);
  }

  Future<List<String>> getAll() async {
    final categoryEither = await _getAllCategoriesUseCase();
    return categoryEither.fold((l) => throw CategoryApiException(l.message), (r) => r);
  }

}
