import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{

  LocalNotificationService._();
  static LocalNotificationService localNotificationService = LocalNotificationService._();

  FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  //initialization
  Future<void> initNotification() async {
    notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
    AndroidInitializationSettings android = AndroidInitializationSettings("mipmap/ic_launcher");//assets/SplashScreen/appIcon.png
    DarwinInitializationSettings iOS = DarwinInitializationSettings();
    InitializationSettings settings = InitializationSettings(
      android: android,
      iOS: iOS
    );
    await notificationsPlugin.initialize(settings);
  }

  //show notification
  Future<void> showNotification(String title,String body) async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      "QuickChat",
      "Local Notification",
      importance: Importance.max,
      priority: Priority.high
    );
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await notificationsPlugin.show(0, title, body, notificationDetails);
  }


}