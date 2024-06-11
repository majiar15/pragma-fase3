import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:api_fake_storage_orm/src/data/api/user/error/user_exception.dart';
import 'package:api_fake_storage_orm/src/domain/models/user.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllUsersUseCase {
  final UserRepository userRepository;

  GetAllUsersUseCase(this.userRepository);

  Future<Either<UserApiException, List<User>>> call(Sort? sort, int? limit) =>
      userRepository.getAllUsers(sort, limit);
}
