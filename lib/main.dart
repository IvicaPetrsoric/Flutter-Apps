import 'package:flutter/material.dart';
import 'package:flutter_apps/OnboardingScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter onboarding UI',
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
