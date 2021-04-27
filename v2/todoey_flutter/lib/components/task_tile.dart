import 'package:flutter/material.dart';
import 'package:todoey_flutter/models/task.dart';

class TaskTile extends StatelessWidget {
  Task task;
  final Function toggleCheckbox;

  TaskTile({this.task, this.toggleCheckbox});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          task.name,
          style: TextStyle(decoration: task.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Checkbox(
          value: task.isDone,
          activeColor: Colors.lightBlueAccent,
          onChanged: toggleCheckbox,
        ));
  }
}
