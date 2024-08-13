import 'package:api_fake_storage_orm/src/data/api/user/error/user_exception.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/user/user_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../repositories/user_repository_test.mocks.dart';

void main() {
  late UserUseCase userUseCase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    userUseCase = UserUseCase(mockUserRepository);
  });

  group('UserUseCase', () {
 const userId = 1;
    const userName = 'testName';
    final user = UserModel(
      address: Address(
        geolocation: Geolocation(
          lat: "40.730610",
          long: "-73.935242",
        ),
        city: "New York",
        street: "5th Avenue",
        number: 123,
        zipcode: "10001",
      ),
      id: userId,
      email: "jhon.doe@example.com",
      username: "jhonDoe",
      password: "password123",
      name: Name(
        firstname: userName,
        lastname: "Doe",
      ),
      phone: "+1234567890",
      v: 0,
  );

    test('debería agregar un usuario y devolver el ID del usuario cuando la llamada sea exitosa', () async {
      when(mockUserRepository.addUser(user))
          .thenAnswer((_) async => Right(user.id));

      final result = await userUseCase.addUser(user);

      expect(result.fold((l) => l, (r) => r), user.id);
    });

    test('debería devolver un UserApiException cuando agregar un usuario falle', () async {
      final exception = UserApiException('Error adding user');
      when(mockUserRepository.addUser(user))
          .thenAnswer((_) async => Left(exception));

      final result = await userUseCase.addUser(user);

      expect(result.fold((l) => l, (r) => r), exception);
    });

    test('debería eliminar un usuario y devolver el usuario eliminado cuando la llamada sea exitosa', () async {
      when(mockUserRepository.deleteUser(1))
          .thenAnswer((_) async => Right(user));

      final result = await userUseCase.deleteUser(1);

      expect(result.fold((l) => l, (r) => r), user);
    });

    test('debería devolver un UserApiException cuando eliminar un usuario falle', () async {
      final exception = UserApiException('Error deleting user');
      when(mockUserRepository.deleteUser(1))
          .thenAnswer((_) async => Left(exception));

      final result = await userUseCase.deleteUser(1);

      expect(result.fold((l) => l, (r) => r), exception);
    });

    test('debería devolver una lista de usuarios cuando la llamada sea exitosa', () async {
      final users = [user];
      when(mockUserRepository.getAllUsers(null, null))
          .thenAnswer((_) async => Right(users));

      final result = await userUseCase.getAllUsers(null, null);

      expect(result.fold((l) => l, (r) => r), users);
    });

    test('debería devolver un UserApiException cuando obtener todos los usuarios falle', () async {
      final exception = UserApiException('Error fetching users');
      when(mockUserRepository.getAllUsers(null, null))
          .thenAnswer((_) async => Left(exception));

      final result = await userUseCase.getAllUsers(null, null);

      expect(result.fold((l) => l, (r) => r), exception);
    });

    test('debería devolver un usuario cuando obtener un usuario por ID sea exitoso', () async {
      when(mockUserRepository.getUserById(1))
          .thenAnswer((_) async => Right(user));

      final result = await userUseCase.getOneUser(1);

      expect(result.fold((l) => l, (r) => r), user);
    });

    test('debería devolver un UserApiException cuando obtener un usuario por ID falle', () async {
      final exception = UserApiException('Error fetching user');
      when(mockUserRepository.getUserById(1))
          .thenAnswer((_) async => Left(exception));

      final result = await userUseCase.getOneUser(1);

      expect(result.fold((l) => l, (r) => r), exception);
    });

    test('debería actualizar un usuario y devolver el usuario actualizado cuando la llamada sea exitosa', () async {
      when(mockUserRepository.updateUser(user))
          .thenAnswer((_) async => Right(user));

      final result = await userUseCase.updateUser(user);

      expect(result.fold((l) => l, (r) => r), user);
    });

    test('debería devolver un UserApiException cuando actualizar un usuario falle', () async {
      final exception = UserApiException('Error updating user');
      when(mockUserRepository.updateUser(user))
          .thenAnswer((_) async => Left(exception));

      final result = await userUseCase.updateUser(user);

      expect(result.fold((l) => l, (r) => r), exception);
    });
  });
}
