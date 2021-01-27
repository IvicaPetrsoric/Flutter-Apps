import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_apps/Model/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  final Function addTaskCallback;

  AddTaskScreen(this.addTaskCallback);

  String newTaskTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Task',
              style: TextStyle(
                fontSize: 30,
                color: Colors.lightBlueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newTaskTitle = newText;
              },
              decoration: InputDecoration(
                hintText: 'Enter Task',
              ),
            ),
            SizedBox(height: 10),
            FlatButton(
              onPressed: () {
                Provider.of<TaskData>(context, listen: false)
                    .addTask(newTaskTitle);
                // addTaskCallback(newTaskTitle);
                Navigator.pop(context);
              },
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
