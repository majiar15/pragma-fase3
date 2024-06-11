import 'dart:async';

import 'package:flutter/material.dart';
import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ApiFakeStorage demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UserModel> users = [];
  int id = 1;

  void _getUserPeriodic(){
    Timer.periodic(
      const Duration(seconds: 2),
      (timer) async {
        try {
          final client = ApiFakeStorageORM();
          final usersResp = await client.user.getOne(id);

          setState(() {
            users.add(usersResp);
            id++;
          });
        } catch (e) {
          timer.cancel();
        }

      }
    );

  }
  @override
  void initState() {
    super.initState();
    _getUserPeriodic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.email),
            subtitle: Text(user.name.firstname),
          );
        },
      )
    );
  }
}
