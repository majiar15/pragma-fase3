import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:api_fake_storage_orm/src/data/api/user/error/user_exception.dart';
import 'package:dartz/dartz.dart';

import '../models/user.dart';

abstract class UserRepository {

  Future<Either<UserApiException, List<User>>> getAllUsers(Sort? sort, int? limit);
  Future<Either<UserApiException, User>> getUserById(int userId);
  Future<Either<UserApiException, int>> addUser(User user);
  Future<Either<UserApiException, User>> updateUser(User user);
  Future<Either<UserApiException, User>> deleteUser(int userId);

}
