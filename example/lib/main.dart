
import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
void main() async {
  final client = ApiFakeStorageORM();

  try {
    Product product = Product(id: 1, title: "title", price: 12, description: "description", category: "category", image: "image");

    final result = await client.product.create(product);
    print(result.title);

  } catch (e) {
    print(e);
  }
}
