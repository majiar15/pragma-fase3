import 'package:api_fake_store_orm/src/data/api/cart/error/cart_exception.dart';

class CartNotFoundException extends CartApiException {
  CartNotFoundException(super.message);
}