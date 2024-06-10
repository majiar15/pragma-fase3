import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';

void main() async {
  final client = ApiFakeStorageORM();

  try {

    final result = await client.category.getAll();
    print(result);
  } catch (e) {
    print(e);
  }
}
