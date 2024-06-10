
import 'package:api_fake_storage_orm/src/data/api/category/error/category_exception.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {

  Future<Either<CategoryApiException, List<String>>> getAllCategories();

}