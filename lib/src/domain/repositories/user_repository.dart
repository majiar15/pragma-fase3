import 'package:dartz/dartz.dart';

import '../models/user.dart';

abstract class UserRepository {

  Future<Either<String, List<User>>> getAllUsers();
  Future<Either<String, User>> getUserById(int userId);
  Future<Either<String, User>> addUser(User user);
  Future<Either<String, User>> updateUser(User user);
  Future<Either<String, User>> deleteUser(int userId);

}
