import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/components/task_tile.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:todoey_flutter/models/tasks.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Tasks>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskTile(
              task: taskData.getTask(index),
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
