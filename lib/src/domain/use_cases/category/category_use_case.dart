import 'package:api_fake_storage_orm/src/data/api/category/error/category_exception.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class CategoriesUseCase {

  final CategoryRepository _categoryRepository;

  CategoriesUseCase(this._categoryRepository);

  Future<Either<CategoryApiException, List<String>>> getAll() => _categoryRepository.getAllCategories();

}
