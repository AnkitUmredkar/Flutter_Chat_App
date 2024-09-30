import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controller/chat_controller.dart';
import 'Controller/controller.dart';
import 'View/User/profile_controller.dart';

Controller controller = Get.put(Controller());
ChatController chatController = Get.put(ChatController());
ProfileController profileController = Get.put(ProfileController());
Color bgColor = const Color(0xff0B141B);