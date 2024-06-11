import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';

void main() async {
  final client = ApiFakeStorageORM();

  try {

    final result = await client.user.getAll(limit: 3, sort: Sort.asc);
    result.forEach((e) => print(e.name.firstname));
  } catch (e) {
    print(e);
  }
}
