library api_fake_storage_orm;

import 'package:api_fake_storage_orm/src/domain/managers/cart/cart_manager.dart';
import 'package:api_fake_storage_orm/src/domain/managers/product/product_manager.dart';
import 'package:api_fake_storage_orm/src/domain/managers/users/user_manager.dart';

// export modules
export './src/domain/models/product.dart' show Product, Rating;
export './src/domain/models/cart.dart' show Cart, ProductCart;
export './src/domain/models/user.dart' show User, Name, Address, Geolocation;

class ApiFakeStorageORM {
  ProductManager product;
  UserManager user;
  CartManager cart;

  ApiFakeStorageORM._({
    required this.product,
    required this.user,
    required this.cart,
  });

  factory ApiFakeStorageORM() {
    return ApiFakeStorageORM._(
      product: ProductManager(),
      user: UserManager(),
      cart: CartManager()
    );
  }
}
