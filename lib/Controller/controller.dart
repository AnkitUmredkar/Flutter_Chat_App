import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controller extends GetxController{
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  RxString currentUserName = ''.obs;
  Rx<dynamic> currentUserImg = ''.obs;

  void showCurrentUser(var name, var img){
    currentUserName.value = name;
    currentUserImg.value = img;
  }
}