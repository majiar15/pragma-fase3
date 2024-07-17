# Fake Storage ORM

Fake Storage ORM es un paquete ORM (Object-Relational Mapping) para Flutter que facilita la interacción con la API Fake Storage. Este paquete proporciona una manera sencilla y eficiente de realizar operaciones CRUD (Crear, Leer, Actualizar, Eliminar) en los datos almacenados en la API Fake Storage.

## Features

- **Fácil de usar**: Interfaz intuitiva para realizar operaciones CRUD.
- **Alta eficiencia**: Optimizado para un rendimiento rápido y eficiente.
- **Integración perfecta**: Se integra perfectamente con tu aplicación Flutter.

## Getting started


### Instalación

```yml
api_fake_storage_orm:
  git:
    url: https://github.com/majiar15/pragma-fase3.git
    branch: main
```

### Ejemplo

```dart
import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';

void main() async {
  final client = ApiFakeStorageORM();

  try {

    final result = await client.user.getAll(limit: 3, sort: Sort.asc);
    print(result);
  } catch (e) {
    print(e);
  }
}
```

### Recursos y metodos disponibles

#### Product

1. **obtener todos los productos** - este método puede recibir un limite y un sort para filtrar los datos, devuelve una lista de productos.
```dart
final client = ApiFakeStorageORM();
final result = await client.product.getAll(limit: 3, sort: Sort.asc);
```

2. **obtener un productos** - este método recibe un productId para buscarlo y devolverlo.
```dart
final client = ApiFakeStorageORM();
final result = await client.product.getOne(3);
```

3. **obtener todos los productos por categoria** - este metodo recibe una categoria y devuelve una lista de productos.
```dart
final client = ApiFakeStorageORM();
final result = await client.product.getByCategory('Electronic');
```

4. **crear un producto** - este método recibe un producto y devuelve el producto creado.
```dart
  final client = ApiFakeStorageORM();

  ProductModel product = ProductModel(title: "title", price: 12, description: "description", category: "category", image: "image")

  final result = await client.product.create(product);
```

5. **actualiza un producto** - este método recibe un producto y devuelve el producto modificado.
```dart
  final client = ApiFakeStorageORM();

  ProductModel product = ProductModel(id: 2, title: "title", price: 12, description: "description", category: "category", image: "image")

  final result = await client.product.update(product);
```
6. **elimina un producto** - este método recibe un id y devuelve el producto eliminado
```dart
  final client = ApiFakeStorageORM();


  final result = await client.product.delete(5);
```

#### User

1. **obtener todos los usuarios** - este método puede recibir un limite y un sort para filtrar los datos, devuelve una lista de usuarios.
```dart
  final client = ApiFakeStorageORM();

  final result = await client.user.getAll(limit: 3, sort: Sort.asc);
```

2. **obtener un  usuario** - este método recibe un userId y devuelve un usuario
```dart
  final client = ApiFakeStorageORM();

  final result = await client.user.getOne(4);
```

3. **crear un usuario** - este método recibe un Usuario y devuelve el un userId
```dart

  final client = ApiFakeStorageORM();

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

    UserModel user = UserModel(
      address: address,
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
  final result = await client.user.create(user);
```


4. **actualizar un  usuario** - este método recibe un usuario y devuelve el usuario modificado
```dart

  final client = ApiFakeStorageORM();

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

    UserModel user = UserModel(
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
```

5. **eliminar un  usuario** - este método recibe un userId y devuelve el usuario eliminado
```dart
  final client = ApiFakeStorageORM();

  final result = await client.user.delete(4);
```
#### Cart
1. **obtener todos los carritos** - este método puede recibir un limite y un sort para filtrar los datos, devuelve una lista de carritos.
```dart
  final client = ApiFakeStorageORM();

  final result = await client.cart.getAll(limit: 3, sort: Sort.asc);
```

2. **obtener un carrito** - este método recibe un cartId y devuelve un carrito.
```dart
  final client = ApiFakeStorageORM();

  final result = await client.cart.getOne(4);
```
3. **obtener carrito de usuario** - este método recibe un userId y devuelve un carrito perteneciente al usuario.
```dart
  final client = ApiFakeStorageORM();

  final result = await client.cart.getOneByUser(4);
```
4. **crear un carrito** - este método recibe un userId, una lista de ProductCart y devuelve un carrito nuevo.
```dart
  final client = ApiFakeStorageORM();
  int userId = 4;

  ProductCart product1 = ProductCart(productId: 5, quantity: 1);
  ProductCart product2 = ProductCart(productId: 1, quantity: 2);
  ProductCart product3 = ProductCart(productId: 8, quantity: 1);

  List<ProductCart> products = [product1,product2,product3];
  final result = await client.cart.create(userId, products);
```
5. **actualizar un carrito** - este método recibe un cartId, userId, una lista de ProductCart y devuelve un carrito editado.
```dart
  final client = ApiFakeStorageORM();
  int userId = 4;
  int cartId = 1;

  ProductCart product1 = ProductCart(productId: 5, quantity: 1);
  ProductCart product2 = ProductCart(productId: 1, quantity: 2);
  ProductCart product3 = ProductCart(productId: 8, quantity: 1);

  List<ProductCart> products = [product1,product2,product3];
  final result = await client.cart.update(cartId, userId, products);
```
6. **eliminar un carrito** - este método recibe un cartId y devuelve el id del carrito eliminado.
```dart
  final client = ApiFakeStorageORM();
  final result = await client.cart.delete(3);
```
#### Auth
  1. **Login** este metodo recibe un userName y una contraseña, devuelve un token de acceso
  ```dart
  final client = ApiFakeStorageORM();
  final result = await client.auth.login("mor_2314", "83r5^_");
  ```
#### Category
1. **obtener todas las categorias** este metodo devuelve todas las categorias
```dart
  final client = ApiFakeStorageORM();
  final result = await client.category.getAll();
  ```

para mas informacion consultar
[Api Fake Storage](https://fakestoreapi.com/docs) 