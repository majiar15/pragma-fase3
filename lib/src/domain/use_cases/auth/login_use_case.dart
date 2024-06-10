import 'package:api_fake_storage_orm/src/data/api/auth/error/auth_exception.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';


class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<Either<AuthApiException, String>> call(String userName, String password) =>
      authRepository.login(userName, password);
}
