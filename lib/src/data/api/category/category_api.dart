import 'dart:convert';

import 'package:api_fake_storage_orm/src/common/config/environment.dart';
import 'package:api_fake_storage_orm/src/data/api/category/error/category_exception.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class CategoryApi extends CategoryRepository {
  final headers = {'Content-Type': 'application/json'};
  final http.Client client;

  CategoryApi({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<Either<CategoryApiException, List<String>>> getAllCategories() async {
    try {
      final response = await client.get(
        Uri.parse('${Environment.apiUrl}/products/categories'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<String> categories = data.map((dt) => dt.toString()).toList();
        return Right(categories);
      } else {
        return Left(
          CategoryApiException('category not found, Please try again later'),
        );
      }
    } catch (e) {
      return Left(CategoryApiException(e.toString()));
    }
  }

}