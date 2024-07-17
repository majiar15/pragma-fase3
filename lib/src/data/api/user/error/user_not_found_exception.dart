import 'package:api_fake_store_orm/src/data/api/user/error/user_exception.dart';

class UserNotFoundException extends UserApiException {
  UserNotFoundException(super.message);
}