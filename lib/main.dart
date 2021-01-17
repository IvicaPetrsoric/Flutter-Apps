import 'package:flutter/material.dart';
import 'package:flutter_apps/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pet Adoption UI',
      theme: ThemeData(
        primaryColor: Color(0xFFFD6456),
      ),
      home: HomeScreen(),
    );
  }
}
