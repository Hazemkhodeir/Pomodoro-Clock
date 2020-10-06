import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:timer_clock/services/task_data.dart';
import 'package:provider/provider.dart';

class TaskDetailScreen extends StatelessWidget {
  final int position;
  TaskDetailScreen(this.position);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xffffe0B2), Color(0xffef6c00)],
          begin: FractionalOffset(0.5, 1),
        )),
        child: Column(
          children: <Widget>[
            Text(
              '${Provider.of<TaskData>(context).tasks[position].name}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: CircularPercentIndicator(
                percent: Provider.of<TaskData>(context).tasks[position].percent,
                animation: true,
                animateFromLastPercent: true,
                radius: 250,
                lineWidth: 25,
                animationDuration: 3000,
                progressColor: Color(0xffef6c00),
                backgroundColor: Colors.yellow[700],
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  '${((Provider.of<TaskData>(context).tasks[position].duration - Provider.of<TaskData>(context).tasks[position].timePassed) ~/ 60).toInt().toString()}:${((Provider.of<TaskData>(context).tasks[position].duration - Provider.of<TaskData>(context).tasks[position].timePassed) % 60).toInt().toString()}',
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      print('Start Clicked ');
                      try {
                        Provider.of<TaskData>(context, listen: false)
                            .startTimer(
                                Provider.of<TaskData>(context, listen: false)
                                    .tasks[position]);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.play_arrow),
                          Text(
                            'Start',
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      print('Cancel Clicked ');
                      try {
                        Provider.of<TaskData>(context, listen: false)
                            .cancelTimer();
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.pause),
                          Text(
                            'Pause',
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
