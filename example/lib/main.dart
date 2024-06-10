import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';

void main() async {
  final client = ApiFakeStorageORM();

  try {
    Address address = Address(
      geolocation: Geolocation(
        lat: '40.730610',
        long: '-73.935242',
      ),
      city: 'New York',
      street: '5th Avenue',
      number: 123,
      zipcode: '10001',
    );

    User user = User(
      address: address,
      id: 1,
      email: 'john.doe@example.com',
      username: 'johndoe',
      password: 'securepassword',
      name: Name(
        firstname: 'Jhon',
        lastname: "doe",
      ),
      phone: '123-456-7890',
      v: 1,
    );

    final result = await client.user.update(user);
    print(result.email);
  } catch (e) {
    print(e);
  }
}
