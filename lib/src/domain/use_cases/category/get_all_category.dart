import 'package:api_fake_storage_orm/src/data/api/category/error/category_exception.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllCategoriesUseCase {

  final CategoryRepository categoryRepository;

  GetAllCategoriesUseCase(this.categoryRepository);

  Future<Either<CategoryApiException, List<String>>> call() => categoryRepository.getAllCategories();

}
