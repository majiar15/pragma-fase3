import 'package:api_fake_storage_orm/src/data/api/auth/error/auth_exception.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/auth/auth_use_case.dart';

class AuthManager {
  final AuthUseCase _authUseCase;

  AuthManager(this._authUseCase);

  Future<String> login(String userName, String password) async {
    final authEither = await _authUseCase.login(userName, password);
    return authEither.fold(
      (l) => throw AuthApiException(l.message),
      (r) => r,
    );
  }
}


