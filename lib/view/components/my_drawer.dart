import 'package:chatting_app/View/Settings/settings_page.dart';
import 'package:chatting_app/View/User/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Services/auth_services.dart';
import '../../Services/google_auth_service.dart';
import '../../Services/online_status.dart';
import '../../global.dart';
import '../Auth/show_option.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  Future<void> logout() async {
    //call signOut method
    await AuthService.authService.signOut();
    await GoogleAuthService.googleAuthService.signOutFromGoogle();
    User? user = AuthService.authService.getCurrentUser();
    if (user == null) {
      Get.off(const ShowOption());
      OnlineStatus.onlineStatus.updateOnlineStatus(false);
    }
    controller.txtPassword.clear();
    controller.txtEmail.clear();
    controller.txtName.clear();
    controller.txtPhone.clear();
    controller.txtConfirmPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface, //const Color(0xff12131e),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  border: Border(),
                ),
                child: Center(
                  child: Icon(Icons.message,
                      size: width * 0.1),
                ),
              ),
              CustomListTile(
                icon: Icons.home,
                title: "Home",
                onTap: () {Navigator.pop(context);},
              ),
              CustomListTile(
                  icon: Icons.person,
                  title: "Profile",
                  onTap: () {Get.to(UserProfile());}),
              CustomListTile(
                  icon: Icons.settings,
                  title: "Settings",
                  onTap: () {Get.to(SettingsPage());}),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: CustomListTile(
              icon: Icons.logout,
              title: "Logout",
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }

  Padding menu() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ListTile(
        onTap: () {
          Get.to(UserProfile());
        },
        leading: const Icon(Icons.person, color: Colors.white70),
        title: const Text("Profile", style: TextStyle(fontFamily: 'pr', color: Colors.white70,
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const CustomListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ListTile(
          onTap: onTap,
          leading: Icon(
            icon,
            color: controller.isDarkMode.value ? Colors.white70 : Colors.black87,
          ),
          title: Text(
            title,
            style: TextStyle(fontFamily: 'pr', color: controller.isDarkMode.value ? Colors.white70 : Colors.black87,),
          ),
        ),
    );
  }
}
