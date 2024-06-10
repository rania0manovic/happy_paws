import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalNotificationService {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> setup() async {
    const androidInitializationSetting =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitializationSetting = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
        android: androidInitializationSetting, iOS: iosInitializationSetting);
    await _flutterLocalNotificationsPlugin.initialize(initSettings);
  }
   Future<bool> requestNotificationPermission() async {
    if (await Permission.notification.isGranted) {
      return true;
    } else if (await Permission.notification.isDenied) {
      PermissionStatus status = await Permission.notification.request();
      return status == PermissionStatus.granted;
    } else if (await Permission.notification.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }
    return false;
  }
  Future<void> showNotification() async {
    var androidChannelSpecifics = const AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(android:  androidChannelSpecifics,iOS:  iosChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,  // Notification ID
      'Test Title', // Notification Title
      'Test Body', // Notification Body, set as null to remove the body
      platformChannelSpecifics,
      payload: 'New Payload', // Notification Payload
    );
}
}
