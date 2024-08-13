import 'dart:convert';

import 'package:api_fake_storage_orm/src/common/config/environment.dart';
import 'package:api_fake_storage_orm/src/data/api/user/error/user_exception.dart';
import 'package:api_fake_storage_orm/src/data/api/user/user_api.dart';
import 'package:api_fake_storage_orm/src/data/api/user/error/user_not_found_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';

import 'user_api_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])

void main() {
  late UserApi userApi;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    userApi = UserApi(client: mockClient);
  });

  group('UserApi', () {
    const userId = 1;
    const userName = 'testName';
    final userModel = UserModel(
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

    test('successful getAllUsers returns list of users', () async {
      final userList = [userModel];

      when(mockClient.get(
        Uri.parse('${Environment.apiUrl}/users'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          jsonEncode(userList.map((e) => e.toJson()).toList()), 200));

      final result = await userApi.getAllUsers(null, null);

      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r.length), userList.length);
      expect(result.fold((l) => l, (r) => r[0].id), userList[0].id);
    });

    test('failed getAllUsers returns UserNotFoundException', () async {
      when(mockClient.get(
        Uri.parse('${Environment.apiUrl}/users'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Users not found', 404));

      final result = await userApi.getAllUsers(null, null);

      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<UserNotFoundException>()),
        (r) => fail('Expected a Left but got a Right'),
      );
    });

    test('successful getUserById returns user', () async {
      when(mockClient.get(
        Uri.parse('${Environment.apiUrl}/users/$userId'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          jsonEncode(userModel.toJson()), 200));

      final result = await userApi.getUserById(userId);

      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r.id), userModel.id);
    });

    test('failed getUserById returns UserNotFoundException', () async {
      when(mockClient.get(
        Uri.parse('${Environment.apiUrl}/users/$userId'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('User not found', 404));

      final result = await userApi.getUserById(userId);

      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<UserNotFoundException>()),
        (r) => fail('Expected a Left but got a Right'),
      );
    });

    test('successful addUser returns user ID', () async {
      when(mockClient.post(
        Uri.parse('${Environment.apiUrl}/users'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
          jsonEncode({'id': userId}), 200));

      final result = await userApi.addUser(userModel);

      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r), userId);
    });

    test('failed addUser returns UserNotFoundException', () async {
      when(mockClient.post(
        Uri.parse('${Environment.apiUrl}/users'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
          'The user could not be saved', 400));

      final result = await userApi.addUser(userModel);

      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<UserNotFoundException>()),
        (r) => fail('Expected a Left but got a Right'),
      );
    });

    test('successful deleteUser returns deleted user', () async {
      when(mockClient.delete(
        Uri.parse('${Environment.apiUrl}/users/$userId'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          jsonEncode(userModel.toJson()), 200));

      final result = await userApi.deleteUser(userId);

      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r.id), userModel.id);
    });

    test('failed deleteUser returns UserApiException', () async {
      when(mockClient.delete(
        Uri.parse('${Environment.apiUrl}/users/$userId'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          'Unable to delete the user', 400));

      final result = await userApi.deleteUser(userId);

      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<UserApiException>()),
        (r) => fail('Expected a Left but got a Right'),
      );
    });

    test('successful updateUser returns updated user', () async {
      when(mockClient.put(
        Uri.parse('${Environment.apiUrl}/users/$userId'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
          jsonEncode(userModel.toJson()), 200));

      final result = await userApi.updateUser(userModel);

      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r.id), userModel.id);
    });

    test('failed updateUser returns UserApiException', () async {
      when(mockClient.put(
        Uri.parse('${Environment.apiUrl}/users/$userId'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
          'Error updating the user', 400));

      final result = await userApi.updateUser(userModel);

      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<UserApiException>()),
        (r) => fail('Expected a Left but got a Right'),
      );
    });
  });
}