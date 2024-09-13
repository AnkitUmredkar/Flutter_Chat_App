import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyTextFormField extends StatelessWidget {
  final String labelText;
  var obscureText;
  var keyBoardType;
  final TextEditingController controller;

  MyTextFormField({super.key,
    required this.labelText,
    required this.controller,
    this.keyBoardType,
    this.obscureText});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return SizedBox(
      height: height * 0.0825,
      child: TextFormField(
        keyboardType: keyBoardType ?? TextInputType.text,
        obscureText: obscureText ?? false,
        controller: controller,
        style: const TextStyle(fontFamily: 'pr', fontWeight: FontWeight.w500),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // onTapOutside: (event) => FocusScope.of(context).requestFocus(FocusNode()),
        validator: (value) {
          if (labelText == "Email" &&
              !RegExp(r'^[a-z0-9._%+-]+@gmail\.com$').hasMatch(value!) &&
              value.isNotEmpty) {
            return "Please enter a valid email";
          }else if (labelText == "Password" && value!.length < 6) {
            return 'Password must be at least 6 characters long';
          } else if (labelText == 'Name' && value!.isEmpty ||
              labelText == 'Phone' && value!.isEmpty ||
              labelText == "Email" && value!.isEmpty ||
              labelText == "Confirm Password" && value!.isEmpty
          ) {
            return '$labelText is required!';
          }
          return null;
        },
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.grey.shade600),
          labelText: labelText,
          // filled: true,
          // fillColor: Theme.of(context).colorScheme.secondary,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade800)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade800, width: 2)),
        ),
      ),
    );
  }
}

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