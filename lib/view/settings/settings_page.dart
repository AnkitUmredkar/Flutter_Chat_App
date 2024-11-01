import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        titleSpacing: 7,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        title: Text(
          'Settings',
          style: TextStyle(
              fontFamily: 'pr',
              fontWeight: FontWeight.w600,
              fontSize: width * 0.061),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(controller.isDarkMode.value ? 'Dark Mode' : 'Light Mode',style: TextStyle(fontFamily: 'pr'),),
              CupertinoSwitch(
                value: controller.isDarkMode.value,
                onChanged: (value) {
                  return controller.toggleTheme(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
