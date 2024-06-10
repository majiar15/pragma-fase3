import 'package:api_fake_storage_orm/src/data/api/user/error/user_exception.dart';
import 'package:api_fake_storage_orm/src/domain/models/user.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetOneUsersUseCase {
  final UserRepository userRepository;

  GetOneUsersUseCase(this.userRepository);

  Future<Either<UserApiException, User>> call(int userId) =>
      userRepository.getUserById(userId);
}
