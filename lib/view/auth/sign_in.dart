import 'package:chatting_app/Services/auth_services.dart';
import 'package:chatting_app/Services/google_auth_service.dart';
import 'package:chatting_app/View/Auth/sign_up.dart';
import 'package:chatting_app/View/Home/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global.dart';
import '../../Model/user_model.dart';
import '../../Services/cloud_firestore_service.dart';
import '../components/my_button.dart';
import '../components/my_textField.dart';

GlobalKey<FormState> _formKey = GlobalKey();

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: height * 0.27,
                width: width,
                decoration: const BoxDecoration(color: Color(0xff12131e)),
                //0xff0D0D19
                child: Stack(
                  children: [
                    Positioned(
                      top: -180,
                      left: -101,
                      child: Container(
                        height: width * 1.12,
                        width: width * 1.12,//450
                        padding: EdgeInsets.only(right: 80, bottom: 80),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.06),
                            shape: BoxShape.circle),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.075),
                              shape: BoxShape.circle),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 17, bottom: height * 0.03),
                        child: Text(
                          'Sign in to your\nAccount',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'pb',
                              color: Colors.white,
                              fontSize: width * 0.07),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(18, height * 0.055, 18, 8),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //todo ---------------------------------------> email
                        MyTextFormField(
                            labelText: 'Email',
                            controller: controller.txtEmail,
                            icon: Icons.email_outlined,),
                        SizedBox(
                          height: height * 0.018,
                        ),
                        //todo ---------------------------------------> password
                        MyTextFormField(
                          labelText: 'Password',
                          obscureText: true,
                          controller: controller.txtPassword,
                          icon: Icons.lock_outline,),
                        const SizedBox(
                          height: 4,
                        ),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot Password ?',
                            style: TextStyle(
                                color: Color(0xff9bc73e), fontFamily: 'pb'),
                          ),
                        ),
                        SizedBox(height: height * 0.04),
                        //todo ---------------------------------------> login button
                        MyButton(onTap: _loginProcess, title: 'Login'),
                        SizedBox(height: height * 0.044),
                        //todo ---------------------------------------> text : Or login with
                        Row(
                          children: [
                            _buildLine(),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              // Space between divider and text
                              child: Text(
                                'Or login with',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'pr',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            _buildLine(),
                          ],
                        ),
                        SizedBox(height: height * 0.044),
                        //todo ---------------------------------------> Google SignIn Option
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                  onTap: () async {
                                    await GoogleAuthService.googleAuthService.signInWithGoogle();
                                    User? user = AuthService.authService.getCurrentUser();
                                    UserModel userModel = UserModel(
                                      name: user!.displayName,
                                      email: user.email,
                                      image: user.photoURL,
                                      phone: user.phoneNumber,
                                      token: "----",
                                      isOnline: true,
                                      isTyping: false,
                                      timestamp: Timestamp.now(),
                                      about: "Hey there i am using QuickChat",
                                    );
                                    await CloudFireStoreService.cloudFireStoreService.insertUserIntoFireStore(userModel);
                                    Get.offAll(() => const HomePage());
                                    showToast( "Successfully login\n Welcome back to QuickChat!!");
                                  },
                                  child: buildSignInOption(width, 'assets/LoginPage/google.png', 'Google')),
                            ),
                            SizedBox(width: width * 0.04),
                            Expanded(
                                child: buildSignInOption(width, 'assets/LoginPage/facebook.png', 'Facebook')),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.059,
                        ),
                        //todo ---------------------------------------> go to sign up
                        GestureDetector(
                          onTap: () {
                            Get.off(const SignUp(),
                                transition: Transition.rightToLeft,
                                duration: const Duration(milliseconds: 500));
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Don't have account?",
                                    style: TextStyle(
                                        fontFamily: 'pr',
                                        color: Colors.grey.shade600)),
                                const TextSpan(
                                    text: ' Sign Up',
                                    style: TextStyle(
                                        fontFamily: 'pb', color: Color(0xff9bc73e)))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Container buildSignInOption(double width, String logo, String label){
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          logo,
          width: width * 0.049,
        ),
        const SizedBox(width: 10.5),
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: width * 0.039,
            fontFamily: 'pr',
          ),
        )
      ],
    ),
  );
}

Future<void> _loginProcess() async {
  if (_formKey.currentState!.validate()) {
    String response = await AuthService.authService
        .signInWithEmailAndPassword(
        controller.txtEmail.text,
        controller.txtPassword.text);
    // await CloudFireStoreService.cloudFireStoreService.getCurrentUserFromFireStore();
    //User null or not
    User? user = AuthService.authService.getCurrentUser();
    if (user != null && response == 'success') {
      Get.offAll(() => const HomePage(),
          transition: Transition.fade);
      showToast("Successfully login\n Welcome back to QuickChat!!");
    } else {
      showToast('Email or Password is wrong');
    }
  }
}

Expanded _buildLine() {
  return Expanded(
    child: Divider(
      thickness: 1,
      color: Colors.grey.shade400,
      indent: 10,
      endIndent: 10,
    ),
  );
}

// GestureDetector(
//   onTap: () async {
//     String response = await AuthService.authService
//         .signInWithEmailAndPassword(
//         controller.txtEmail.text,
//         controller.txtPassword.text);
//
//     //User null or not
//     User? user = AuthService.authService.getCurrentUser();
//     if (user != null && response == 'success') {
//       Get.off(HomePage(
//         isFirstTime: true,
//       ));
//     } else {
//       Get.snackbar('Sign in Failed', response);
//     }
//   },
//   child: Container(
//     alignment: Alignment.center,
//     padding: EdgeInsets.symmetric(vertical: 14),
//     width: width,
//     decoration: BoxDecoration(
//       color: Color(0xffacda4b),
//       borderRadius: BorderRadius.circular(12)
//     ),
//     child: Text(
//       'Login',
//       style: TextStyle(
//           fontFamily: 'pr',
//           fontSize: width * 0.04,
//           fontWeight: FontWeight.bold),
//     ),
//   ),
// ),

// ElevatedButton(
//     onPressed: () async {
//       String response = await AuthService.authService
//           .signInWithEmailAndPassword(
//               controller.txtEmail.text,
//               controller.txtPassword.text);
//
//       //User null or not
//       User? user = AuthService.authService.getCurrentUser();
//       if (user != null && response == 'success') {
//         Get.off(HomePage(
//           isFirstTime: true,
//         ));
//       } else {
//         Get.snackbar('Sign in Failed', response);
//       }
//     },
//     child: const Text('Submit')),

// AnimatedButton(
//   height: height * 0.071,
//   width: width * 0.82,
//   color: const Color(0xffacda4b),
//   onPressed: () async {
//     if(_formKey.currentState!.validate()){
//       String response = await AuthService.authService
//           .signInWithEmailAndPassword(
//           controller.txtEmail.text,
//           controller.txtPassword.text);
//       // await CloudFireStoreService.cloudFireStoreService.getCurrentUserFromFireStore();
//       //User null or not
//       User? user = AuthService.authService.getCurrentUser();
//       if (user != null && response == 'success') {
//         Get.offAll(() => const HomePage(),
//             transition: Transition.fade);
//         showToast( "Successfully login\n Welcome back to QuickChat!!");
//       } else {
//         showToast('Email or Password is wrong');
//       }
//     }
//   },
//   child: Text(
//     'Login',
//     style: TextStyle(
//         fontFamily: 'pr',
//         fontSize: width * 0.04,
//         fontWeight: FontWeight.bold),
//   ),
// ),