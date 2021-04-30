import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/components/tasks_list.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:todoey_flutter/models/tasks.dart';

import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            showModalBottomSheet(context: context, builder: (context) => Container(child: AddTaskScreen())),
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
                  '${Provider.of<Tasks>(context).taskCount} tasks',
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
              child: TasksList(),
            ),
          )
        ],
      ),
    );
  }
}
