
import 'package:api_fake_storage_orm/src/data/api/auth/error/auth_exception.dart';
import 'package:dartz/dartz.dart';


abstract class AuthRepository {

  Future<Either<AuthApiException, String>> login(String userName, String password);

}