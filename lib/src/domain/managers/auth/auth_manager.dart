import 'package:api_fake_storage_orm/src/data/api/auth/auth_api.dart';
import 'package:api_fake_storage_orm/src/data/api/product/errors/product_exception.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/auth_repository.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/auth/login_use_case.dart';
import 'package:dartz/dartz.dart';

class AuthManager {
  final AuthRepository _authRepository = AuthApi();
  late final LoginUseCase _loginUseCase;

  AuthManager() {
    _loginUseCase = LoginUseCase(_authRepository);
  }

  Future<String> login(String userName, String password) async {
    final authEither = await _loginUseCase(userName, password);
    return authEither.fold((l) => throw ProductApiException(l.message), (r) => r);
  }

}
