import 'dart:convert';

import 'package:api_fake_store_orm/src/common/config/environment.dart';
import 'package:api_fake_store_orm/src/data/api/auth/error/auth_exception.dart';
import 'package:api_fake_store_orm/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthApi extends AuthRepository {
  final headers = {'Content-Type': 'application/json'};

  @override
  Future<Either<AuthApiException, String>> login(String userName, String password) async {
    try {
       final body = jsonEncode({
          "username": userName,
          "password": password
       });
      final response = await http.post(
        Uri.parse('${Environment.apiUrl}/auth/login'),
        body: body,
        headers: headers,
      );
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        String token = data["token"];
        return Right(token);
      } else {
        return Left(
          AuthApiException('Invalid Credential'),
        );
      }
    } catch (e) {
      return Left(AuthApiException(e.toString()));
    }
  }

}