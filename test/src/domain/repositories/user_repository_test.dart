import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:api_fake_storage_orm/src/data/api/user/error/user_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/user_repository.dart';

import 'user_repository_test.mocks.dart';


@GenerateMocks([UserRepository])
void main() {
  late UserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
  });

  group('UserRepository', () {
    final userModel = UserModel(
      id: 1,
      email: 'test@example.com',
      username: 'testuser',
      password: 'password',
      name: Name(firstname: 'John', lastname: 'Doe'),
      phone: '1234567890',
      address: Address(
        geolocation: Geolocation(lat: '0.0', long: '0.0'),
        city: 'Test City',
        street: '123 Test St',
        number: 1,
        zipcode: '12345',
      ),
      v: 1,
    );
    final userList = [userModel];

    test('debería devolver una lista de usuarios cuando la llamada a getAllUsers sea exitosa', () async {
      when(mockRepository.getAllUsers(Sort.asc, 10))
          .thenAnswer((_) async => Right(userList));

      final result = await mockRepository.getAllUsers(Sort.asc, 10);

      expect(result, Right(userList));
    });

    test('debería devolver un usuario cuando la llamada a getUserById sea exitosa', () async {
      when(mockRepository.getUserById(1))
          .thenAnswer((_) async => Right(userModel));

      final result = await mockRepository.getUserById(1);

      expect(result, Right(userModel));
    });

    test('debería devolver un ID de usuario cuando la llamada a addUser sea exitosa', () async {
      when(mockRepository.addUser(userModel))
          .thenAnswer((_) async => Right(1));

      final result = await mockRepository.addUser(userModel);

      expect(result, Right(1));
    });

    test('debería devolver un UserModel cuando la llamada a updateUser sea exitosa', () async {
      when(mockRepository.updateUser(userModel))
          .thenAnswer((_) async => Right(userModel));

      final result = await mockRepository.updateUser(userModel);

      expect(result, Right(userModel));
    });

    test('debería devolver un UserModel cuando la llamada a deleteUser sea exitosa', () async {
      when(mockRepository.deleteUser(1))
          .thenAnswer((_) async => Right(userModel));

      final result = await mockRepository.deleteUser(1);

      expect(result, Right(userModel));
    });

    test('debería lanzar un UserApiException cuando la llamada falle', () async {
      final exception = UserApiException('Error al obtener usuarios');
      when(mockRepository.getAllUsers(Sort.asc, 10))
          .thenAnswer((_) async => Left(exception));

      final result = await mockRepository.getAllUsers(Sort.asc, 10);

      expect(result, Left(exception));
    });
  });
}
