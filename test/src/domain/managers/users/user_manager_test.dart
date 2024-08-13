import 'package:api_fake_storage_orm/src/data/api/user/error/user_exception.dart';
import 'package:api_fake_storage_orm/src/domain/managers/users/user_manager.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/user/user_use_case.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'user_manager_test.mocks.dart';


@GenerateMocks([UserUseCase])
void main() {
  late UserManager userManager;
  late MockUserUseCase mockUserUseCase;

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

  setUp(() {
    mockUserUseCase = MockUserUseCase();
    userManager = UserManager(mockUserUseCase);
  });

  group('UserManager', () {
    test('debería devolver una lista de usuarios cuando getAll sea exitoso', () async {
      final users = [user,user];
      when(mockUserUseCase.getAllUsers(any, any)).thenAnswer((_) async => Right(users));

      final result = await userManager.getAll();

      expect(result, users);
    });

    test('debería lanzar una UserApiException cuando getAll falle', () async {
      final exception = UserApiException('Error al obtener los usuarios');
      when(mockUserUseCase.getAllUsers(any, any)).thenAnswer((_) async => Left(exception));

      expect(() async => await userManager.getAll(), throwsA(isA<UserApiException>()));
    });

    test('debería devolver un usuario cuando getOne sea exitoso', () async {
      when(mockUserUseCase.getOneUser(any)).thenAnswer((_) async => Right(user));

      final result = await userManager.getOne(1);

      expect(result, user);
    });

    test('debería lanzar una UserApiException cuando getOne falle', () async {
      final exception = UserApiException('Error al obtener el usuario');
      when(mockUserUseCase.getOneUser(any)).thenAnswer((_) async => Left(exception));

      expect(() async => await userManager.getOne(1), throwsA(isA<UserApiException>()));
    });

    test('debería crear un usuario cuando create sea exitoso', () async {
      when(mockUserUseCase.addUser(any)).thenAnswer((_) async => Right(1));

      final result = await userManager.create(user);

      expect(result, 1);
    });

    test('debería lanzar una UserApiException cuando create falle', () async {
      final exception = UserApiException('Error al crear el usuario');
      when(mockUserUseCase.addUser(any)).thenAnswer((_) async => Left(exception));

      expect(() async => await userManager.create(user), throwsA(isA<UserApiException>()));
    });

    test('debería eliminar un usuario cuando delete sea exitoso', () async {

      when(mockUserUseCase.deleteUser(any)).thenAnswer((_) async => Right(user));

      final result = await userManager.delete(1);

      expect(result, user);
    });

    test('debería lanzar una UserApiException cuando delete falle', () async {
      final exception = UserApiException('Error al eliminar el usuario');
      when(mockUserUseCase.deleteUser(any)).thenAnswer((_) async => Left(exception));

      expect(() async => await userManager.delete(1), throwsA(isA<UserApiException>()));
    });

    test('debería actualizar un usuario cuando update sea exitoso', () async {

      when(mockUserUseCase.updateUser(any)).thenAnswer((_) async => Right(user));

      final result = await userManager.update(user);

      expect(result, user);
    });

    test('debería lanzar una UserApiException cuando update falle', () async {
      final exception = UserApiException('Error al actualizar el usuario');
      when(mockUserUseCase.updateUser(any)).thenAnswer((_) async => Left(exception));

      expect(() async => await userManager.update(user), throwsA(isA<UserApiException>()));
    });
  });
}
