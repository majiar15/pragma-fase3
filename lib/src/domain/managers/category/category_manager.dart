
import 'package:api_fake_storage_orm/src/data/api/category/error/category_exception.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/category/category_use_case.dart';

class CategoryManager {
  late final CategoriesUseCase _categoriesUseCase;

  CategoryManager(
    this._categoriesUseCase
  );

  Future<List<String>> getAll() async {
    final categoryEither = await _categoriesUseCase.getAll();
    return categoryEither.fold((l) => throw CategoryApiException(l.message), (r) => r);
  }

}
