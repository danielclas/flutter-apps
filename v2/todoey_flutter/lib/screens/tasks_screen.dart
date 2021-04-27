import 'package:flutter/material.dart';
import 'package:todoey_flutter/components/tasks_list.dart';
import 'package:todoey_flutter/models/task.dart';

import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Task> tasks = [Task(name: 'Buy milk'), Task(name: 'Buy eggs'), Task(name: 'Buy bread')];

  addTaskCallback(String name) => setState(() => this.tasks.add(Task(name: name)));
  toggleTaskCallback(value, index) => setState(() => tasks[index].toggleDone(value));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) => Container(
                    child: AddTaskScreen(
                  addTaskCallback: addTaskCallback,
                ))),
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.list,
                    size: 30,
                    color: Colors.lightBlueAccent,
                  ),
                  backgroundColor: Colors.white,
                  radius: 30,
                ),
                SizedBox(height: 10),
                Text('Todoey',
                    style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w700)),
                Text(
                  '12 tasks',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: TasksList(
                tasks: tasks,
                toggleTaskCallback: toggleTaskCallback,
              ),
            ),
          )
        ],
      ),
    );
  }
}
