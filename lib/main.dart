import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:timer_clock/services/notfication_helper.dart';
import 'package:timer_clock/services/sql_helper.dart';
import 'package:timer_clock/services/task_data.dart';
import 'package:timer_clock/screens/task_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    AndroidInitializationSettings androidInitializationSettings;
    InitializationSettings initializationSettings;
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    initializationSettings =
        InitializationSettings(androidInitializationSettings, null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  } catch (e) {
    print(e);
  }
  final NotificationHelper notificationHelper =
      NotificationHelper(flutterLocalNotificationsPlugin);

  runApp(MyApp(notificationHelper));
}

class MyApp extends StatelessWidget {
  final NotificationHelper _notificationHelper;
  MyApp(
    this._notificationHelper,
  );
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DatabaseHelper()),
        ChangeNotifierProxyProvider<DatabaseHelper, TaskData>(
          create: (context) => TaskData(
              notificationHelper: _notificationHelper, databaseHelper: null),
          update: (context, db, previous) => TaskData(
              notificationHelper: _notificationHelper, databaseHelper: db),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TasksScreen(),
      ),
    );
  }
}
