import 'dart:convert';

import 'package:api_fake_storage_orm/src/common/config/environment.dart';
import 'package:api_fake_storage_orm/src/data/api/user/error/user_exception.dart';
import 'package:api_fake_storage_orm/src/data/api/user/error/user_not_found_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../domain/models/user.dart';
import '../../../domain/repositories/user_repository.dart';

class UserApi extends UserRepository {
  final headers = {'Content-Type': 'application/json'};

  @override
  Future<Either<UserApiException, List<User>>> getAllUsers() async {
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/users'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<User> users = User.fromJsonList(data);
        return Right(users);
      } else {
        return Left(
          UserNotFoundException('Users not found, Please try again later'),
        );
      }
    } catch (e) {
      return Left(UserApiException(e.toString()));
    }
  }

  @override
  Future<Either<UserApiException, User>> getUserById(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/users/$userId'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        User user = User.fromJson(data);
        return Right(user);
      } else {
        return Left(
          UserNotFoundException('User not found, Please try again later'),
        );
      }
    } catch (e) {
      return Left(UserApiException(e.toString()));
    }
  }

  @override
  Future<Either<UserApiException, int>> addUser(User user) async {
    try {
      final body = jsonEncode(user);
      final response = await http.post(
        Uri.parse('${Environment.apiUrl}/users'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        return Right(data["id"]);
      } else {
        return Left(
          UserNotFoundException(
              'The user could not be saved. Please try again later'),
        );
      }
    } catch (e) {
      return Left(UserApiException(e.toString()));
    }
  }

  @override
  Future<Either<UserApiException, User>> deleteUser(int userId) async {
    try {
      final response = await http.delete(
        Uri.parse('${Environment.apiUrl}/users/$userId'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        User product = User.fromJson(data);
        return Right(product);
      } else {
        return Left(
          UserApiException('Unable to delete the user. Try again later.'),
        );
      }
    } catch (e) {
      return Left(UserApiException(e.toString()));
    }
  }

  @override
  Future<Either<UserApiException, User>> updateUser(User user) async {
    try {
      final body = jsonEncode(user);
      final response = await http.put(
        Uri.parse('${Environment.apiUrl}/users/${user.id}'),
        body: body,
        headers: headers,
      );

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        User products = User.fromJson(data);
        return Right(products);
      } else {
        return Left(
          UserApiException('Error updating the user. Try again.'),
        );
      }
    } catch (e) {
      return Left(UserApiException(e.toString()));
    }
  }
}
