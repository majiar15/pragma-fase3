
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {

  Future<Either<String, List<String>>> getAllCategories();

}