import 'package:animated_button/animated_button.dart';
import 'package:chatting_app/Services/auth_services.dart';
import 'package:chatting_app/View/Auth/sign_in.dart';
import 'package:chatting_app/View/Auth/sign_up.dart';
import 'package:chatting_app/View/Home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowOption extends StatelessWidget {
  const ShowOption({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff12131e),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.white,
                    size: width * 0.15,
                  ),
                  SizedBox(height: height * 0.09),
                  Text(
                    "Welcome back, you've missed!",
                    style: TextStyle(fontFamily: 'pr',color: Colors.white,fontSize: width * 0.034),
                  ),
                  SizedBox(
                    height: height * 0.062,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(const SignIn(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 500));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: height * 0.072,
                          width: width * 0.84,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xffacda4b)),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontFamily: 'pr', fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.022),
                      GestureDetector(
                        onTap: () {
                          Get.to(const SignUp(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 500));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: height * 0.072,
                          width: width * 0.84,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: const Color(0xffacda4b),
                                  strokeAlign: BorderSide.strokeAlignInside)),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontFamily: 'pr', fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: height * 0.024),
                child: GestureDetector(
                  onTap: () async {
                    await AuthService.authService.signInAnonymously();
                    Get.off(const HomePage());
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Continue as a",
                            style: TextStyle(
                                fontFamily: 'pr',
                                color: Colors.white70,
                                fontSize: width * 0.042)),
                        TextSpan(
                            text: ' Guest',
                            style: TextStyle(
                                fontFamily: 'pb',
                                color: const Color(0xff9bc73e),
                                fontSize: width * 0.042))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
