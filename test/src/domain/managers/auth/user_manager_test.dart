import 'package:api_fake_storage_orm/src/data/api/auth/error/auth_exception.dart';
import 'package:api_fake_storage_orm/src/domain/managers/auth/auth_manager.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_manager_test.mocks.dart';

@GenerateMocks([AuthUseCase])
void main() {
  late AuthManager authManager;
  late MockAuthUseCase mockAuthUseCase;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    authManager = AuthManager(mockAuthUseCase);
  });

  group('AuthManager', () {
    test('debería retornar un token cuando el login sea exitoso', () async {
      const userName = 'testUser';
      const password = 'testPassword';
      const token = 'authToken';
      when(mockAuthUseCase.login(userName, password))
          .thenAnswer((_) async => const Right(token));

      final result = await authManager.login(userName, password);

      expect(result, token);
    });

    test('debería lanzar una ProductApiException cuando el login falle', () async {
      const userName = 'testUser';
      const password = 'testPassword';
      final exception = AuthApiException('Error de autenticación');
      when(mockAuthUseCase.login(userName, password))
          .thenAnswer((_) async => Left(exception));
        try {
          await authManager.login(userName, password);
        } catch (e) {
          expect(
            e,
            isA<AuthApiException>(),
          );
        }

    });
  });
}
