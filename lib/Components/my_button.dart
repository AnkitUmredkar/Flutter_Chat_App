import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{
  final String title;
  final void Function()? onTap;
  MyButton({super.key,required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AnimatedButton(
      height: height * 0.071,
      width: width * 0.82,
      color: const Color(0xffacda4b),
      onPressed: onTap!,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
            fontFamily: 'pr',
            fontSize: width * 0.04,
            fontWeight: FontWeight.bold),
      ),
    );
  }

}