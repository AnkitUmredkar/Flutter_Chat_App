import 'package:chatting_app/Services/auth_services.dart';
import 'package:chatting_app/Services/google_auth_service.dart';
import 'package:chatting_app/View/Auth/show_option.dart';
import 'package:chatting_app/View/Auth/sign_in.dart';
import 'package:chatting_app/View/Search/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/controller.dart';
import '../../Global/global.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff12131e),
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.transparent,
          title: Text(
            'QuickChat',
            style: TextStyle(color: Colors.white,fontFamily: 'pr',fontWeight: FontWeight.w600,fontSize: width * 0.058),
          ),
          actions: [
            const Icon(
              Icons.add,
              color: Colors.white,
            ),
            IconButton(
              onPressed: () async {
                //call signOut method
                await AuthService.authService.signOut();
                await GoogleAuthService.googleAuthService.signOutFromGoogle();
                User? user = AuthService.authService.getCurrentUser();
                if (user == null) {
                  Get.off(const ShowOption());
                }
                controller.txtPassword.clear();
                controller.txtEmail.clear();
                controller.txtName.clear();
                controller.txtPhone.clear();
                controller.txtConfirmPassword.clear();
              },
              icon: const Icon(Icons.logout,color: Colors.white,),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15,6,10,2),
            child: Obx(
              () => Column(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(const SearchPage()),
                    child: Hero(
                      tag: "search",
                      child: Material(
                        color: Colors.transparent,
                        child: TextField(
                          enabled: false,
                          // showCursor: true,
                          // cursorColor: Colors.white60,
                          style: const TextStyle(color: Colors.white60),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xff24252a),
                            hintText: "Search",
                            hintStyle: const TextStyle(
                                fontFamily: 'pr', color: Colors.white70),
                            // contentPadding: EdgeInsets.symmetric(
                            //     vertical: 13.h, horizontal: 15.w),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300, shape: BoxShape.circle),
                    child: ClipOval(
                      child: Image.network(
                        controller.currentUserImg.value,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.person,
                              color: Colors.grey.shade700,
                              size: 50); // Fallback to user icon
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    controller.currentUserName.value,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
