import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'Controller/chat_controller.dart';
import 'Controller/controller.dart';
import 'View/User/profile_controller.dart';

Controller controller = Get.put(Controller());
ChatController chatController = Get.put(ChatController());
ProfileController profileController = Get.put(ProfileController());
Color bgColor = const Color(0xff0B141B);

Future<bool?> showToast(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16,
  );
}