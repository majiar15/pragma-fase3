import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:api_fake_storage_orm/src/common/config/environment.dart';
import 'package:api_fake_storage_orm/src/common/utils/formatted_date.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_exception.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/error/cart_not_found_exception.dart';
import 'package:api_fake_storage_orm/src/domain/models/cart.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/cart_repository.dart';

import 'package:dartz/dartz.dart';

class CartApi extends CartRepository {
  final headers = {'Content-Type': 'application/json'};

  @override
  Future<Either<CartApiException, int>> addCart(
    int userId,
    List<ProductCart> products,
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
  Future<Either<CartApiException, Cart>> deleteCart(int cartId) async {
    try {
      final response = await http.delete(
        Uri.parse('${Environment.apiUrl}/carts/$cartId'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        Cart cart = Cart.fromJson(data);
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
  Future<Either<CartApiException, List<Cart>>> getAllCarts() async {
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/carts'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Cart> carts = Cart.fromJsonList(data);
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
  Future<Either<CartApiException, Cart>> getCartById(int cartId) async {
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/carts/$cartId'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        Cart cart = Cart.fromJson(data);
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
  Future<Either<CartApiException, Cart>> getCartByUserId(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/carts/user/$userId'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        Cart cart = Cart.fromJsonList(data)[0];
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
    List<ProductCart> products,
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
