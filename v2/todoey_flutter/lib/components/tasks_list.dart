import 'package:flutter/material.dart';
import 'package:todoey_flutter/components/task_tile.dart';
import 'package:todoey_flutter/models/task.dart';

class TasksList extends StatelessWidget {
  List<Task> tasks;
  final Function toggleTaskCallback;

  TasksList({this.tasks, this.toggleTaskCallback});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return TaskTile(
          task: tasks[index],
          toggleCheckbox: (value) => toggleTaskCallback(value, index),
        );
      },
      itemCount: tasks.length,
    );
  }
}
