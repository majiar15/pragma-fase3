import 'dart:convert';
import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:api_fake_storage_orm/src/common/utils/add_parameter_url.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_models_commons/flutter_models_commons.dart' show ProductCartApi, CartApiModel;

import 'package:api_fake_storage_orm/src/common/config/environment.dart';
import 'package:api_fake_storage_orm/src/common/utils/formatted_date.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_not_found_exception.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/cart_repository.dart';

import 'package:dartz/dartz.dart';

class CartApi extends CartRepository {
  final headers = {'Content-Type': 'application/json'};

  @override
  Future<Either<CartApiException, int>> addCart(
    int userId,
    List<ProductCartApi> products,
  ) async {
    try {
      DateTime now = DateTime.now();
      final body = jsonEncode({
        "userId": userId,
        "products": products,
        "date": FormattedDate.format(now)
      });
      final response = await http.post(
        Uri.parse('${Environment.apiUrl}/carts'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        return Right(data["id"]);
      } else {
        return Left(
          CartApiException(
              'The cart could not be saved. Please try again later'),
        );
      }
    } catch (e) {
      return Left(CartApiException(e.toString()));
    }
  }

  @override
  Future<Either<CartApiException, CartApiModel>> deleteCart(int cartId) async {
    try {
      final response = await http.delete(
        Uri.parse('${Environment.apiUrl}/carts/$cartId'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        CartApiModel cart = CartApiModel.fromJson(data);
        return Right(cart);
      } else {
        return Left(
          CartApiException('Unable to delete the cart. Try again later.'),
        );
      }
    } catch (e) {
      return Left(CartApiException(e.toString()));
    }
  }

  @override
  Future<Either<CartApiException, List<CartApiModel>>> getAllCarts(Sort? sort, int? limit) async {
    try {
      String url = '${Environment.apiUrl}/carts';
      url = AddParametersURL.addSortToUrl(url, sort);
      url = AddParametersURL.addLimitToUrl(url, limit);

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<CartApiModel> carts = CartApiModel.fromJsonList(data);
        return Right(carts);
      } else {
        return Left(
          CartNotFoundException('Carts not found, Please try again later'),
        );
      }
    } catch (e) {
      return Left(CartApiException(e.toString()));
    }
  }

  @override
  Future<Either<CartApiException, CartApiModel>> getCartById(int cartId) async {
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/carts/$cartId'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        CartApiModel cart = CartApiModel.fromJson(data);
        return Right(cart);
      } else {
        return Left(
          CartNotFoundException('Cart not found, Please try again later'),
        );
      }
    } catch (e) {
      return Left(CartApiException(e.toString()));
    }
  }

  @override
  Future<Either<CartApiException, CartApiModel>> getCartByUserId(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/carts/user/$userId'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        CartApiModel cart = CartApiModel.fromJsonList(data)[0];
        return Right(cart);
      } else {
        return Left(
          CartNotFoundException('Cart not found, Please try again later'),
        );
      }
    } catch (e) {
      return Left(CartApiException(e.toString()));
    }
  }

  @override
  Future<Either<CartApiException, int>> updateProductsCart(
    int cartId,
    int userId,
    List<ProductCartApi> products,
  ) async {
    try {
      DateTime now = DateTime.now();
      final body = jsonEncode({
        "userId": userId,
        "products": products,
        "date": FormattedDate.format(now)
      });
      final response = await http.put(
        Uri.parse('${Environment.apiUrl}/carts/$cartId'),
        body: body,
        headers: headers,
      );

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        return Right(data["id"]);
      } else {
        return Left(
          CartApiException('Error updating the cart. Try again.'),
        );
      }
    } catch (e) {
      return Left(CartApiException(e.toString()));
    }
  }
}
