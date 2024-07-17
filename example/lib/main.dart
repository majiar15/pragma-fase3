import 'package:flutter/material.dart';
import 'package:api_fake_store_orm/api_fake_store_orm.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fake Storage ORM Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserDetailScreen(),
    );
  }
}


class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  createState() => _UserDetailScreenState();
}


class _UserDetailScreenState extends State<UserDetailScreen> {
  late Future<UserModel> userFuture;  // Future que contendrá los datos del usuario
  final int userId = 1;  // ID de usuario de ejemplo

  @override
  void initState() {
    super.initState();
    // Inicializamos el cliente de la API
    final client = ApiFakeStorageORM();
    // realizamos consulta para obtener usuario con ID 1
    userFuture = client.user.getOne(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: FutureBuilder<UserModel>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          else if (snapshot.hasData) {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${user.id}', style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 8),
                  Text('Name: ${user.name.firstname}', style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 8),
                  Text('Email: ${user.email}', style: const TextStyle(fontSize: 20)),
                ],
              ),
            );
          }
          else {
            return const Center(child: Text('No user found'));
          }
        },
      ),
    );
  }
}
