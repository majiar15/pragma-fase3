import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:api_fake_storage_orm/src/data/api/user/error/user_exception.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';

class UserUseCase {
  final UserRepository _userRepository;

  UserUseCase(this._userRepository);

  Future<Either<UserApiException, int>> addUser(UserModel user) =>
    _userRepository.addUser(user);

  Future<Either<UserApiException, UserModel>> deleteUser(int userId) =>
    _userRepository.deleteUser(userId);

  Future<Either<UserApiException, List<UserModel>>> getAllUsers(Sort? sort, int? limit) =>
    _userRepository.getAllUsers(sort, limit);

  Future<Either<UserApiException, UserModel>> getOneUser(int userId) =>
    _userRepository.getUserById(userId);

  Future<Either<UserApiException, UserModel>> updateUser(UserModel user) =>
    _userRepository.updateUser(user);
}
