import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  void showNotificationAndroid(String title, String value) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'Channel Name',
            channelDescription: 'Channel Description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    int notificationId = 1;
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin
        .show(notificationId, title, value, notificationDetails, payload: 'Not present');
  }


void showNotificationIos(String title, String value) async {
    const DarwinNotificationDetails  iOSPlatformChannelSpecifics =
    DarwinNotificationDetails (
        presentAlert: true,  // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        presentBadge: true,  // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        presentSound: true,  // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        // sound: String?,  // Specifics the file path to play (only from iOS 10 onwards)
        // badgeNumber: int?, // The application's icon badge number
        // attachments: List<IOSNotificationAttachment>?, (only from iOS 10 onwards)
        // subtitle: String?, //Secondary description  (only from iOS 10 onwards)
        // threadIdentifier: String? (only from iOS 10 onwards)
   );

    int notificationId = 1;
      
  const NotificationDetails platformChannelSpecifics = 
      NotificationDetails(iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin
        .show(notificationId, title, value, platformChannelSpecifics, payload: 'Not present');
  }
}