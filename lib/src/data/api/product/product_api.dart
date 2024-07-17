import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_models_commons/flutter_models_commons.dart';

import 'package:api_fake_store_orm/src/common/config/environment.dart';
import 'package:api_fake_store_orm/src/common/enum/sort.dart';
import 'package:api_fake_store_orm/src/common/utils/add_parameter_url.dart';
import 'package:api_fake_store_orm/src/data/api/product/errors/product_exception.dart';
import 'package:api_fake_store_orm/src/data/api/product/errors/product_not_found_exception.dart';
import '../../../domain/repositories/product_repository.dart';

class ProductApi extends ProductRepository {
  final headers = {'Content-Type': 'application/json'};

  @override
  Future<Either<ProductApiException, List<ProductModel>>> getAllProducts(Sort? sort, int? limit) async {
    try {
      String url = '${Environment.apiUrl}/products';
      url = AddParametersURL.addSortToUrl(url, sort);
      url = AddParametersURL.addLimitToUrl(url, limit);

      final response = await http
          .get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<ProductModel> products = ProductModel.fromJsonList(data);
        return Right(products);
      } else {
        return Left(
          ProductNotFoundException(
              'Products not found, Please try again later'),
        );
      }
    } catch (e) {
      return Left(ProductApiException(e.toString()));
    }
  }

  @override
  Future<Either<ProductApiException, ProductModel>> getProductById(int id) async {
    try {
      final response = await http.get(
          Uri.parse('https://fakestoreapi.com/products/$id'),
          headers: headers);
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        ProductModel products = ProductModel.fromJson(data);
        return Right(products);
      } else {
        return Left(
          ProductNotFoundException('Product not found, Please try again later'),
        );
      }
    } catch (e) {
      return Left(ProductApiException(e.toString()));
    }
  }

  @override
  Future<Either<ProductApiException, ProductModel>> addProduct(
      ProductModel product) async {
    try {
      final body = jsonEncode(product);
      final response = await http.post(
          Uri.parse('${Environment.apiUrl}/products'),
          headers: headers,
          body: body);
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        ProductModel product = ProductModel.fromJson(data);
        return Right(product);
      } else {
        return Left(
          ProductApiException(
              'The product could not be saved. Please try again later'),
        );
      }
    } catch (e) {
      return Left(ProductApiException(e.toString()));
    }
  }

  @override
  Future<Either<ProductApiException, ProductModel>> deleteProduct(
    int productId,
  ) async {
    try {
      final response = await http.delete(
          Uri.parse('${Environment.apiUrl}/products/$productId'),
          headers: headers);
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        ProductModel product = ProductModel.fromJson(data);
        return Right(product);
      } else {
        return Left(
          ProductApiException('Unable to delete the product. Try again later.'),
        );
      }
    } catch (e) {
      return Left(ProductApiException(e.toString()));
    }
  }

  @override
  Future<Either<ProductApiException, List<ProductModel>>> getProductByCategory(
    String category,
  ) async {
    try {
      final response = await http.get(
          Uri.parse('${Environment.apiUrl}/products/category/$category'),
          headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<ProductModel> products = ProductModel.fromJsonList(data);
        return Right(products);
      } else {
        return Left(
          ProductNotFoundException(
              'Products not found, Please try again later'),
        );
      }
    } catch (e) {
      return Left(ProductApiException(e.toString()));
    }
  }

  @override
  Future<Either<ProductApiException, ProductModel>> updateProduct(
    ProductModel product,
  ) async {
    try {
      final body = jsonEncode(product);
      final response = await http.put(
          Uri.parse('${Environment.apiUrl}/products/${product.id}'),
          body: body,
          headers: headers);

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        ProductModel products = ProductModel.fromJson(data);
        return Right(products);
      } else {
        return Left(
          ProductApiException('Error updating the product. Try again.'),
        );
      }
    } catch (e) {
      return Left(ProductApiException(e.toString()));
    }
  }
}
