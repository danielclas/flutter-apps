import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:todoey_flutter/models/tasks.dart';

class AddTaskScreen extends StatelessWidget {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xff757575),
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
          margin: EdgeInsets.only(bottom: 50),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 30),
              ),
              TextField(
                controller: textController,
                autofocus: true,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () =>
                    Provider.of<Tasks>(context, listen: false).addTask(Task(name: textController.text)),
                child: Text('Add'),
                color: Colors.lightBlueAccent,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
