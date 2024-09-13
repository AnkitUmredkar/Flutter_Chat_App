import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xff12131e),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8,0,15,0),
          child: Column(
            children: [
              SizedBox(height: height * 0.02),
              Row(
                children: [
                  IconButton(onPressed: (){
                    return Get.back();
                  }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                  Expanded(
                    child: Hero(
                    tag: "search",
                    child: Material(
                      color: Colors.transparent,
                      child: TextField(
                        showCursor: true,
                        cursorColor: Colors.white60,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xff24252a),
                          hintText: "Search",
                          hintStyle: const TextStyle(fontFamily: 'pr',color: Colors.white60),
                          // contentPadding: EdgeInsets.symmetric(
                          //     vertical: 13.h, horizontal: 15.w),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
