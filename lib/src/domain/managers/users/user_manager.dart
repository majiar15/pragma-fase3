
import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:api_fake_storage_orm/src/data/api/user/error/user_exception.dart';
import 'package:api_fake_storage_orm/src/data/api/user/user_api.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/user_repository.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/user/user_use_case.dart';
import 'package:dartz/dartz.dart';

class UserManager {
  final UserRepository _userRepository = UserApi();

  late final UserUseCase _userUseCase;

  UserManager() {
    _userUseCase = UserUseCase(_userRepository);
  }

  Future<List<UserModel>> getAll({Sort? sort, int? limit}) async {
    final usersEither = await _userUseCase.getAllUsers(sort, limit);
    return usersEither.fold((l) => throw UserApiException(l.message), (r) => r);
  }

  Future<UserModel> getOne(int userId) async {
    final usersEither = await _userUseCase.getOneUser(userId);
    return usersEither.fold((l) => throw UserApiException(l.message), (r) => r);
  }

  Future<int> create(UserModel user) async {
    final usersEither = await _userUseCase.addUser(user);
    return usersEither.fold((l) => throw UserApiException(l.message), (r) => r);
  }

  Future<UserModel> delete(int userId) async {
    final usersEither = await _userUseCase.deleteUser(userId);
    return usersEither.fold((l) => throw UserApiException(l.message), (r) => r);
  }

  Future<UserModel> update(UserModel user) async {
    final usersEither = await _userUseCase.updateUser(user);
    return usersEither.fold((l) => throw UserApiException(l.message), (r) => r);
  }

}
