import 'package:api_fake_storage_orm/src/data/api/user/error/user_exception.dart';
import 'package:api_fake_storage_orm/src/domain/models/user.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUsersUseCase {
  final UserRepository userRepository;

  UpdateUsersUseCase(this.userRepository);

  Future<Either<UserApiException, User>> call(User user) =>
      userRepository.updateUser(user);
}
