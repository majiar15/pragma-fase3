
import 'package:api_fake_storage_orm/src/data/api/user/error/user_exception.dart';
import 'package:api_fake_storage_orm/src/data/api/user/user_api.dart';
import 'package:api_fake_storage_orm/src/domain/models/user.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/user_repository.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/user/add_user_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/user/delete_user_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/user/get_all_users_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/user/get_one_user_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/user/update_user_use_case.dart';
import 'package:dartz/dartz.dart';

class UserManager {
  final UserRepository _userRepository = UserApi();

  late final GetAllUsersUseCase _getAllUsersUseCase;
  late final GetOneUsersUseCase _getOneUserUseCase;
  late final AddUsersUseCase _addUserUseCase;
  late final DeleteUsersUseCase _deleteUserUseCase;
  late final UpdateUsersUseCase _updateUserUseCase;

  UserManager() {
    _getAllUsersUseCase = GetAllUsersUseCase(_userRepository);
    _getOneUserUseCase = GetOneUsersUseCase(_userRepository);
    _addUserUseCase = AddUsersUseCase(_userRepository);
    _deleteUserUseCase = DeleteUsersUseCase(_userRepository);
    _updateUserUseCase = UpdateUsersUseCase(_userRepository);
  }

  Future<List<User>> getAll() async {
    final usersEither = await _getAllUsersUseCase();
    return usersEither.fold((l) => throw UserApiException(l.message), (r) => r);
  }

  Future<User> getOne(int userId) async {
    final usersEither = await _getOneUserUseCase(userId);
    return usersEither.fold((l) => throw UserApiException(l.message), (r) => r);
  }

  Future<int> create(User user) async {
    final usersEither = await _addUserUseCase(user);
    return usersEither.fold((l) => throw UserApiException(l.message), (r) => r);
  }

  Future<User> delete(int userId) async {
    final usersEither = await _deleteUserUseCase(userId);
    return usersEither.fold((l) => throw UserApiException(l.message), (r) => r);
  }

  Future<User> update(User user) async {
    final usersEither = await _updateUserUseCase(user);
    return usersEither.fold((l) => throw UserApiException(l.message), (r) => r);
  }

}
