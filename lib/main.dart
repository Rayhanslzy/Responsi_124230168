import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsi_124230168/screens/login_screen.dart'; // Import login

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('usersBox'); // Box untuk simpan username/password

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsi 168 Meal App',
      theme: ThemeData(
        primarySwatch: Colors.brown, // Sesuai tema makanan
        useMaterial3: true,
      ),
      home: const LoginScreen(), // Halaman pertama LOGIN
    );
  }
}