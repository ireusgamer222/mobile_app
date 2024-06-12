import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stemcapstoneproject/screens/bottomNavigateScreen/bottomNavigateScreen.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notificationsPlugin.initialize(initializationSettings);
  }




  static Future<void> showNotification(double temperature,String xd, String xd1) async {
     AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      xd,
      'High Temperature',
      channelDescription: 'Notification channel for high temperature alerts',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

     NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.show(
      0,
      xd,
      xd1,
      platformChannelSpecifics,
    );
  }

}

