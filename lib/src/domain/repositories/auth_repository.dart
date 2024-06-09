
import 'package:dartz/dartz.dart';


abstract class AuthRepository {

  Future<Either<String, String>> login();

}