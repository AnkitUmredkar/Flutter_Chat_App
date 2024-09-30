import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService{
  FirebaseMessagingService._();
  static FirebaseMessagingService firebaseMessagingService = FirebaseMessagingService._();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestPermission() async {
    NotificationSettings setting = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (setting.authorizationStatus != AuthorizationStatus.authorized) {
      await requestPermission();
    }
  }

  Future<void> getDeviceToken() async {
    String? token = await firebaseMessaging.getToken();
    print("Token is here ------------------> $token");
    }
}