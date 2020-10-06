import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_clock/screens/add_task_screen.dart';
import 'package:timer_clock/services/task_data.dart';
import 'package:timer_clock/screens/task_detail_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orangeAccent[700],
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                context: context, builder: (context) => AddTaskScreen());
          }),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[700],
        leading: Icon(Icons.timer),
        title: Text(
          'Pomodoro',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffffe0B2), Color(0xffef6c00)],
            begin: FractionalOffset(0.5, 1),
          ),
        ),
        child: Consumer<TaskData>(builder: (context, taskdata, child) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: taskdata.taskCount,
            itemBuilder: (BuildContext context, int position) {
              return Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(taskdata.tasks[position].name),
                      subtitle: Text(
                        '${((Provider.of<TaskData>(context).tasks[position].duration - Provider.of<TaskData>(context).tasks[position].timePassed) ~/ 60).toInt()}:${((Provider.of<TaskData>(context).tasks[position].duration - Provider.of<TaskData>(context).tasks[position].timePassed) % 60).toInt()}',
                      ),
                      trailing: GestureDetector(
                        child: Icon(Icons.delete),
                        onTap: () {
                          try {
                            Provider.of<TaskData>(context, listen: false)
                                .databaseHelper
                                .deleteTask(Provider.of<TaskData>(context,
                                        listen: false)
                                    .tasks[position]
                                    .id);
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailScreen(position),
                          ),
                        );
                      },
                    ),
                    LinearPercentIndicator(
                      percent: Provider.of<TaskData>(context)
                          .tasks[position]
                          .percent,
                      progressColor: Colors.orangeAccent[700],
                      lineHeight: 14,
                      center: Text(
                        '${((Provider.of<TaskData>(context).tasks[position].percent) * 100).toInt()}%',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    ));
  }
}
