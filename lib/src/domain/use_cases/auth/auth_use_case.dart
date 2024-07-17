import 'package:api_fake_storage_orm/src/data/api/auth/error/auth_exception.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';


class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<AuthApiException, String>> login(String userName, String password) =>
      _authRepository.login(userName, password);
}
