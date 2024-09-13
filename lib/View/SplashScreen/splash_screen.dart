import 'dart:async';

import 'package:chatting_app/View/Auth/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4),() {
      Get.off(const AuthManager());
    },);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff12131e),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/SplashScreen/img.png',height: height * 0.169,),
              // SizedBox(height: height * 0.022),
              // Text(
              //   'QuickChat',
              //   style: TextStyle(fontFamily: 'pr', fontSize: width * 0.065,color: Colors.white,fontWeight: FontWeight.bold),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}