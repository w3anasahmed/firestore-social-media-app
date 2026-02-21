import 'package:flutter/material.dart';
import 'package:social_app/screens/register_login/login_page.dart';
import 'package:social_app/screens/register_login/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool isLoginPage = true;

  void togglePages() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginPage) {
      return LoginPage(togglePages: togglePages);
    } else {
      return RegisterPage(togglePages: togglePages);
    }
  }
}
