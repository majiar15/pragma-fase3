import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'auth_api_test.mocks.dart';
import 'dart:convert';

import 'package:api_fake_storage_orm/src/common/config/environment.dart';
import 'package:api_fake_storage_orm/src/data/api/auth/auth_api.dart';
import 'package:api_fake_storage_orm/src/data/api/auth/error/auth_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])

void main() {
  group('AuthApi', () {
    late AuthApi authApi;
    late MockClient mockClient;
    const userName = 'testName';
    const password = 'testPassword';
    setUp(() {
      mockClient = MockClient();
      authApi = AuthApi(client: mockClient); 
    });

    test('successful login returns token', () async {

      const token = 'token';

      when(mockClient.post(
        Uri.parse('${Environment.apiUrl}/auth/login'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode({"token": token}), 200));


      final result = await authApi.login(userName, password);

      expect(result, isA<Right>());
      expect(result.getOrElse(() => ''), token);
    });

    test('failed login returns AuthApiException', () async {

      when(mockClient.post(
        Uri.parse('${Environment.apiUrl}/auth/login'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Invalid Credential', 401));


      final result = await authApi.login(userName, password);

      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<AuthApiException>()),
        (r) => fail('Expected a Left but got a Right'),
      );
    });

    test('exception thrown returns AuthApiException', () async {

      when(mockClient.post(
        Uri.parse('${Environment.apiUrl}/auth/login'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenThrow(Exception('Network Error'));

      final result = await authApi.login(userName, password);

      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<AuthApiException>()),
        (r) => fail('Expected a Left but got a Right'),
      );
    });
  });
}
