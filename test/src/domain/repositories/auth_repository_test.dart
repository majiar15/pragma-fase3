import 'package:api_fake_storage_orm/src/domain/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:api_fake_storage_orm/src/data/api/auth/error/auth_exception.dart';

import 'auth_repository_test.mocks.dart';


@GenerateMocks([AuthRepository])
void main() {
  late AuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  group('login', () {
    test('debería devolver un token cuando la llamada sea exitosa', () async {
      final expectedToken = 'fake_token';
      when(mockAuthRepository.login('username', 'password'))
          .thenAnswer((_) async => Right(expectedToken));

      final result = await mockAuthRepository.login('username', 'password');

      expect(result, Right(expectedToken));
    });

    test('debería devolver un AuthApiException cuando la llamada falle', () async {
      final failure = AuthApiException('Error inesperado');
      when(mockAuthRepository.login('username', 'password'))
          .thenAnswer((_) async => Left(failure));

      final result = await mockAuthRepository.login('username', 'password');

      expect(result, Left(failure));
    });
  });
}
