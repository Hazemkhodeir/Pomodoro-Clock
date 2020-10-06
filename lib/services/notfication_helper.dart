import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationHelper(this.flutterLocalNotificationsPlugin);

  Future<void> notification(String title, String content) async {
    print('Notification');
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("Id", "Title", "Body",
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'Test',
            playSound: true);
    IOSNotificationDetails iOSNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iOSNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, title, content, notificationDetails);
  }
}
