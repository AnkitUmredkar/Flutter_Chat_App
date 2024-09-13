import 'package:chatting_app/Services/auth_services.dart';
import 'package:chatting_app/View/Auth/show_option.dart';
import 'package:chatting_app/View/Auth/sign_in.dart';
import 'package:chatting_app/View/Home/home_page.dart';
import 'package:flutter/material.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return (AuthService.authService.getCurrentUser() == null) ? const ShowOption() : const HomePage();
  }
}
