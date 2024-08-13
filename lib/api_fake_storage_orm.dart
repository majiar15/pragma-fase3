library api_fake_storage_orm;

import 'package:api_fake_storage_orm/src/data/api/auth/auth_api.dart';
import 'package:api_fake_storage_orm/src/data/api/cart/cart_api.dart';
import 'package:api_fake_storage_orm/src/data/api/category/category_api.dart';
import 'package:api_fake_storage_orm/src/data/api/product/product_api.dart';
import 'package:api_fake_storage_orm/src/data/api/user/user_api.dart';
import 'package:api_fake_storage_orm/src/domain/managers/auth/auth_manager.dart';
import 'package:api_fake_storage_orm/src/domain/managers/cart/cart_manager.dart';
import 'package:api_fake_storage_orm/src/domain/managers/category/category_manager.dart';
import 'package:api_fake_storage_orm/src/domain/managers/product/product_manager.dart';
import 'package:api_fake_storage_orm/src/domain/managers/users/user_manager.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/cart/cart_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/category/category_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/product/product_use_case.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/user/user_use_case.dart';


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
      product: ProductManager(ProductUseCase(ProductApi())),
      user: UserManager(UserUseCase(UserApi())),
      cart: CartManager(CartUseCase(CartApi())),
      auth: AuthManager(AuthUseCase(AuthApi())),
      category: CategoryManager(CategoriesUseCase(CategoryApi())),
    );
  }
}
