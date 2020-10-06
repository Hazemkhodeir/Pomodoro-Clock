import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_clock/services/task_data.dart';

final textController = TextEditingController();
final durationController = TextEditingController();

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffef6c00),
                fontSize: 30,
              ),
            ),
            TextField(
              controller: textController,
              cursorColor: Color(0xffef6c00),
              textAlign: TextAlign.center,
              decoration: InputDecoration(helperText: 'Task Name'),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 90.0,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: durationController,
                    cursorColor: Color(0xffef6c00),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(helperText: 'Task Duration'),
                    style: TextStyle(fontSize: 80),
                  ),
                ),
                Text('Duration in Minutes')
              ],
            ),
            FlatButton(
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.orangeAccent[700],
              onPressed: () {
                if (textController.text.isNotEmpty &&
                    durationController.text.isNotEmpty) {
                  Provider.of<TaskData>(context, listen: false).addTask(
                      textController.text,
                      int.parse(durationController.text) * 60);
                  textController.clear();
                  durationController.clear();
                  Navigator.pop(context);
                } else {
                  //Make an alert
                  // AlertDialog();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
