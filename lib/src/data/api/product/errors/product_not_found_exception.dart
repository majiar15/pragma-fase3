import 'package:api_fake_store_orm/src/data/api/product/errors/product_exception.dart';

class ProductNotFoundException extends ProductApiException {
  ProductNotFoundException(super.message);
}