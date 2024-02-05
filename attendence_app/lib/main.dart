import 'package:attendence_app/screens/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendence App',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
