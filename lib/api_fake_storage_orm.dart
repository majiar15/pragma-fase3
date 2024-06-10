library api_fake_storage_orm;

import 'package:api_fake_storage_orm/src/domain/managers/product/product_manager.dart';



// export modules
export './src/domain/models/product.dart' show Product, Rating;
export './src/domain/models/cart.dart' show Cart;
export './src/domain/models/user.dart' show User;

class ApiFakeStorageORM {

  ProductManager product;

  ApiFakeStorageORM._({required this.product});

  factory ApiFakeStorageORM(){
    final productManager = ProductManager();
    return ApiFakeStorageORM._(
      product: productManager
    );
  }

}


