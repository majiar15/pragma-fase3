import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
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
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockProductApi extends Mock implements ProductApi {}
class MockUserApi extends Mock implements UserApi {}
class MockCartApi extends Mock implements CartApi {}
class MockAuthApi extends Mock implements AuthApi {}
class MockCategoryApi extends Mock implements CategoryApi {}

void main() {

  test('ApiFakeStorageORM se inicializa correctamente con todas las dependencias', () {
    final apiFakeStorageORM = ApiFakeStorageORM();

    expect(apiFakeStorageORM.product, isA<ProductManager>());
    expect(apiFakeStorageORM.user, isA<UserManager>());
    expect(apiFakeStorageORM.cart, isA<CartManager>());
    expect(apiFakeStorageORM.auth, isA<AuthManager>());
    expect(apiFakeStorageORM.category, isA<CategoryManager>());
  });
}
