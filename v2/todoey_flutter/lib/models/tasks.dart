import 'package:flutter/material.dart';

import 'task.dart';

class Tasks extends ChangeNotifier {
  List<Task> _tasks = [Task(name: 'Buy milk'), Task(name: 'Buy eggs'), Task(name: 'Buy bread')];

  int get taskCount => _tasks.length;
  Task getTask(int index) => _tasks[index];

  addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  toggleTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  deleteTask(Task task) {
    if (task.isDone) {
      _tasks.remove(task);
      notifyListeners();
    }
  }

  //completeTask
}
