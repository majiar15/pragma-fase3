import 'package:api_fake_storage_orm/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:api_fake_storage_orm/src/data/api/auth/error/auth_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


import '../../repositories/auth_repository_test.mocks.dart';


void main() {
  late AuthUseCase authUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authUseCase = AuthUseCase(mockAuthRepository);
  });

  group('AuthUseCase login', () {
    const userName = 'testUser';
    const password = 'testPassword';
    const token = 'dummyToken';

    test('debería devolver un token cuando el inicio de sesión es exitoso', () async {
      when(mockAuthRepository.login(userName, password))
          .thenAnswer((_) async => Right(token));

      final result = await authUseCase.login(userName, password);

      expect(result.fold((l) => l, (r) => r), token);
    });

    test('debería devolver un AuthApiException cuando el inicio de sesión falla', () async {
      final exception = AuthApiException('Invalid credentials');
      when(mockAuthRepository.login(userName, password))
          .thenAnswer((_) async => Left(exception));


      final result = await authUseCase.login(userName, password);


      expect(result.fold((l) => l, (r) => r), exception);
    });
  });
}
