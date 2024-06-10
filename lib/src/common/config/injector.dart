

import 'package:api_fake_storage_orm/src/data/api/product/product_api.dart';
import 'package:api_fake_storage_orm/src/domain/repositories/product_repository.dart';
import 'package:api_fake_storage_orm/src/domain/use_cases/get_all_products_use_case.dart';

class Injector {

  late GetAllProductsUseCase getAllProductsUseCase;


  Injector(){

    ProductRepository productRepository = ProductApi();
    getAllProductsUseCase = GetAllProductsUseCase(productRepository);

  }

}