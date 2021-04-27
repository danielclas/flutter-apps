import 'package:flutter/material.dart';
import 'package:todoey_flutter/models/task.dart';

class AddTaskScreen extends StatelessWidget {
  final Function addTaskCallback;
  final textController = TextEditingController();

  AddTaskScreen({this.addTaskCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
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
              onPressed: () => addTaskCallback(textController.text),
              child: Text('Add'),
              color: Colors.lightBlueAccent,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
