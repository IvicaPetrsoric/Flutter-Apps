import 'package:flutter/material.dart';
import 'package:flutter_apps/screens/task_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_apps/Model/task_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
