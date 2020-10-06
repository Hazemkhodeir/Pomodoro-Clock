import 'dart:async';
import 'dart:collection';
import 'sql_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:timer_clock/services/notfication_helper.dart';
import 'package:timer_clock/models/task.dart';

class TaskData extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  List<Task> _tasks = [];

  Timer timer;
  NotificationHelper notificationHelper;

  TaskData({this.notificationHelper, this.databaseHelper}) {
    if (databaseHelper != null) {
      fetchAndSetData();
    }
  }
  Future<void> fetchAndSetData() async {
    if (databaseHelper.databse != null) {
      // do not execute if db is not instantiate
      final dataList = await databaseHelper.getTaskList();
      _tasks = dataList;
      // _tasks = dataList.map((e) => Task.fromMapObject(e)).toList();
      notifyListeners();
    }
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(this._tasks);
  }

  int get taskCount {
    return tasks.length;
  }

  void addTask(newTaskTitle, duration) async {
    Task task = Task(newTaskTitle, duration, 0, 0);
    await databaseHelper.insertTask(task);
    notifyListeners();
  }

  void startTimer(Task task) async {
    await notificationHelper.notification("Ding Ding", "Time To Start");

    print('Start Funcation');
    try {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (task.duration != task.timePassed) {
          task.timePassed++;
          task.percent = task.timePassed / task.duration;
          databaseHelper.updateTask(task);
          notifyListeners();
        } else {
          notificationHelper.notification(
              'Ding Ding', 'Time is up your task should be finished.');
          timer.cancel();
          notifyListeners();
          print('Done');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void cancelTimer() {
    notificationHelper.notification(
        "Ding Ding", "Don't go away just a five minutes rest");
    timer.cancel();
    notifyListeners();
  }
}
