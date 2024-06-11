# Fake Storage ORM

Fake Storage ORM es un paquete ORM (Object-Relational Mapping) para Flutter que facilita la interacción con la API Fake Storage. Este paquete proporciona una manera sencilla y eficiente de realizar operaciones CRUD (Crear, Leer, Actualizar, Eliminar) en los datos almacenados en la API Fake Storage.

## Features

- **Fácil de usar**: Interfaz intuitiva para realizar operaciones CRUD.
- **Alta eficiencia**: Optimizado para un rendimiento rápido y eficiente.
- **Integración perfecta**: Se integra perfectamente con tu aplicación Flutter.

## Getting started


### Instalación

```bash
flutter pub add api_fake_storage_orm
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

- product
    - Future<List<Product>> getAll({Sort? sort, int? limit})
    - Future<Product> getOne(int userId)
    - Future<List<Product>> getByCategory(String category)
    - Future<Product> create(Product product)
    - Future<Product> update(Product product)
    - Future<Product> delete(int productId)
- user
    - Future<List<User>> getAll({Sort? sort, int? limit})
    - Future<User> getOne(int userId)
    - Future<int> create(User user)
    - Future<User> delete(int userId)
    - Future<User> update(User user)
- cart
    - Future<List<Cart>> getAll({Sort? sort, int? limit})
    - Future<Cart> getOne(int cartId)
    - Future<Cart> getOneByUser(int userId)
    - Future<int> create(int userId, List<ProductCart> products)
    - Future<Cart> delete(int cartId)
    -  Future<int> update( int cartId, int userId,List<ProductCart> products,)
- auth
    - Future<String> login(String userName, String password)
- category
    - Future<List<String>> getAll()


para mas informacion consultar 
[Api Fake Storage](https://fakestoreapi.com/docs) 