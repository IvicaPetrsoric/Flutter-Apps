import 'package:flutter/material.dart';
import 'package:flutter_apps/screens/menu_options_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Select Option UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.black),
      home: MenuOptionsScreen(),
    );
  }
}
