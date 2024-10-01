import 'package:chatting_app/Components/my_button.dart';
import 'package:chatting_app/Model/user_model.dart';
import 'package:chatting_app/Services/auth_services.dart';
import 'package:chatting_app/Services/cloud_firestore_service.dart';
import 'package:chatting_app/View/Auth/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/my_textField.dart';
import '../../global.dart';
import '../Home/home_page.dart';

final GlobalKey<FormState> _formKey = GlobalKey();

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: height * 0.27,
                width: width,
                decoration: const BoxDecoration(color: Color(0xff12131e)),//0xff0D0D19
                child: Stack(
                  children:[
                    Positioned(
                      top: -(height * 0.225),//-180,
                      left: -(width * 0.225),//-101,
                      child: Container(
                        height: width * 1.12,//450,
                        width: width * 1.12,//450,
                        padding: EdgeInsets.only(right: 80,bottom: 80),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.06) ,
                            shape: BoxShape.circle
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.075) ,
                              shape: BoxShape.circle
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 18,bottom: height * 0.03),
                        child: Text('Create your\nAccount',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'pb',color: Colors.white,fontSize: width * 0.07),),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(onPressed: () {
                        Get.back();
                      }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(18, height * 0.027, 18, 8),//height * 0.055
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Fill the below information to create account',
                              style: TextStyle(fontFamily: 'pr',color: Colors.black),
                            )),
                        SizedBox(height: height * 0.027),
                        //todo ---------------------------------------> name
                        MyTextFormField(
                            labelText: 'Name',
                            obscureText: false,
                            controller: controller.txtName,
                            icon: Icons.person),
                        SizedBox(height: height * 0.0138),
                        //todo ---------------------------------------> phone
                        MyTextFormField(
                            labelText: 'Phone',
                            keyBoardType: TextInputType.phone,
                            controller: controller.txtPhone,
                            icon: Icons.phone,),
                        SizedBox(height: height * 0.0138),
                        //todo ---------------------------------------> email
                        MyTextFormField(
                            labelText: 'Email',
                            controller: controller.txtEmail,
                            icon: Icons.email_outlined),
                        SizedBox(height: height * 0.0138),
                        //todo ---------------------------------------> password
                        MyTextFormField(
                            labelText: 'Password',
                            obscureText: true,
                            controller: controller.txtPassword,
                            icon: Icons.lock_outline),
                        SizedBox(height: height * 0.0138),
                        //todo ---------------------------------------> confirm password
                        MyTextFormField(
                            labelText: 'Confirm Password',
                            obscureText: true,
                            controller: controller.txtConfirmPassword,
                            icon: Icons.lock_outline),
                        SizedBox(height: height * 0.035),
                        //todo ---------------------------------------> signUp button
                        // AnimatedButton(
                        //   height: height * 0.071,
                        //   width: width * 0.82,
                        //   color: const Color(0xffacda4b),
                        //   onPressed: () async {
                        //     if (_formKey.currentState!.validate() &&
                        //         controller.txtPassword.text == controller.txtConfirmPassword.text) {
                        //       String response = await AuthService.authService.createUserWithEmailAndPassword(controller.txtEmail.text, controller.txtPassword.text);
                        //
                        //       UserModel userModel = UserModel(
                        //           name: controller.txtName.text,
                        //           email: controller.txtEmail.text,
                        //           image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi2haw1278i40sszGwCvy7LKP3j2KqLTnPJg&s",
                        //           phone: controller.txtPhone.text,
                        //           token: "----",
                        //       );
                        //
                        //       await CloudFireStoreService.cloudFireStoreService.insertUserIntoFireStore(userModel);
                        //       // await CloudFireStoreService.cloudFireStoreService.getCurrentUserFromFireStore();
                        //
                        //       User? user = AuthService.authService.getCurrentUser();
                        //       if (user != null && response == 'success') {
                        //         Get.offAll(const HomePage());
                        //         showToast( "Account created successfully\n Welcome to QuickChat!!");
                        //       } else {
                        //         showToast('Email or Password is wrong');
                        //       }
                        //     }
                        //   },
                        //   child: Text(
                        //     'Sign Up',
                        //     style: TextStyle(
                        //         fontFamily: 'pr',
                        //         fontSize: width * 0.04,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        MyButton(onTap: _signUpProcess, title: 'Sign Up'),
                        SizedBox(height: height * 0.048,),
                        //todo ---------------------------------------> go to login
                        GestureDetector(
                          onTap:() {
                              Get.off(const SignIn(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 500));
                          },
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(text: "Already have account?",style: TextStyle(fontFamily: 'pr',color: Colors.grey.shade600)),
                              const TextSpan(text: ' Login',style: TextStyle(fontFamily: 'pb',color: Color(0xff9bc73e)))
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _signUpProcess() async {
  if (_formKey.currentState!.validate() &&
      controller.txtPassword.text == controller.txtConfirmPassword.text) {
    String response = await AuthService.authService
        .createUserWithEmailAndPassword(
        controller.txtEmail.text, controller.txtPassword.text);

    UserModel userModel = UserModel(
      name: controller.txtName.text,
      email: controller.txtEmail.text,
      image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi2haw1278i40sszGwCvy7LKP3j2KqLTnPJg&s",
      phone: controller.txtPhone.text,
      token: "----",
      isOnline: true,
      isTyping: false,
      timestamp: Timestamp.now(),
      about: "Hey there i am using QuickChat",
    );

    await CloudFireStoreService.cloudFireStoreService.insertUserIntoFireStore(
        userModel);

    User? user = AuthService.authService.getCurrentUser();
    if (user != null && response == 'success') {
      Get.offAll(const HomePage());
      showToast("Account created successfully\n Welcome to QuickChat!!");
    } else {
      showToast('Email or Password is wrong');
    }
  }
  else{
    showToast('Email or Password is wrong');
  }
}