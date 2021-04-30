import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:todoey_flutter/models/tasks.dart';

class TaskTile extends StatelessWidget {
  Task task;

  TaskTile({this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => Provider.of<Tasks>(context, listen: false).deleteTask(task),
      child: ListTile(
          title: Text(
            task.name,
            style: TextStyle(decoration: task.isDone ? TextDecoration.lineThrough : null),
          ),
          trailing: Checkbox(
            value: task.isDone,
            activeColor: Colors.lightBlueAccent,
            onChanged: (value) => Provider.of<Tasks>(context, listen: false).toggleTask(task),
          )),
    );
  }
}
