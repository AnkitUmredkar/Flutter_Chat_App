import 'package:flutter/material.dart';

class MyTheme {

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Colors.white,//Colors.grey.shade300,
        primary: Colors.grey.shade500,
        secondary: Colors.grey.shade200,
        tertiary: Colors.white,
        inversePrimary: Colors.grey.shade700),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        surface: const Color(0xff12131e),
        primary: Colors.grey.shade600,
        secondary: Color(0xff28282d),//const Color.fromARGB(255, 57, 57, 57),
        tertiary: Colors.grey.shade800,
        inversePrimary: Colors.white60),
  );
}
// Color color = Color(0xff24252a); search textField color