import 'package:api_fake_store_orm/api_fake_store_orm.dart';
import 'package:api_fake_store_orm/src/data/api/user/error/user_exception.dart';
import 'package:dartz/dartz.dart';


import 'package:flutter_models_commons/flutter_models_commons.dart';

abstract class UserRepository {

  Future<Either<UserApiException, List<UserModel>>> getAllUsers(Sort? sort, int? limit);
  Future<Either<UserApiException, UserModel>> getUserById(int userId);
  Future<Either<UserApiException, int>> addUser(UserModel user);
  Future<Either<UserApiException, UserModel>> updateUser(UserModel user);
  Future<Either<UserApiException, UserModel>> deleteUser(int userId);

}
