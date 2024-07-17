library api_fake_storage_orm;

import 'package:api_fake_storage_orm/src/domain/managers/auth/auth_manager.dart';
import 'package:api_fake_storage_orm/src/domain/managers/cart/cart_manager.dart';
import 'package:api_fake_storage_orm/src/domain/managers/category/category_manager.dart';
import 'package:api_fake_storage_orm/src/domain/managers/product/product_manager.dart';
import 'package:api_fake_storage_orm/src/domain/managers/users/user_manager.dart';


// export utils

export './src/common/enum/sort.dart' show Sort;

class ApiFakeStorageORM {
  ProductManager product;
  UserManager user;
  CartManager cart;
  AuthManager auth;
  CategoryManager category;

  ApiFakeStorageORM._({
    required this.product,
    required this.user,
    required this.cart,
    required this.auth,
    required this.category,
  });

  factory ApiFakeStorageORM() {
    return ApiFakeStorageORM._(
      product: ProductManager(),
      user: UserManager(),
      cart: CartManager(),
      auth: AuthManager(),
      category: CategoryManager(),
    );
  }
}
