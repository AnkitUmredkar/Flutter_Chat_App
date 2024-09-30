import 'package:chatting_app/Services/firebase_messaging_service.dart';
import 'package:chatting_app/Services/notification_service.dart';
import 'package:chatting_app/View/SplashScreen/splash_screen.dart';
import 'package:chatting_app/global.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Theme/theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalNotificationService.localNotificationService.initNotification();
  await FirebaseMessagingService.firebaseMessagingService.requestPermission();
  await FirebaseMessagingService.firebaseMessagingService.getDeviceToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        themeMode: controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
      ),
    );
  }
}
