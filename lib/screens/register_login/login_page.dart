import 'package:flutter/material.dart';
import 'package:social_app/components/custom_button.dart';
import 'package:social_app/components/custom_textfield.dart';
import 'package:social_app/services/auth/auth_serivce.dart';

class LoginPage extends StatelessWidget {
  final void Function()? togglePages;

  LoginPage({super.key, required this.togglePages});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthSerivce authSerivce = AuthSerivce();

  void login(BuildContext context) async {
    try {
      await authSerivce.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Icon(
                Icons.person,
                size: 100,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              SizedBox(height: 20),
              Text(
                'M I N I M A L',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              SizedBox(height: 50),
              CustomTextfield(
                controller: emailController,
                hintText: 'Email',
                isObscure: false,
              ),

              SizedBox(height: 15),

              CustomTextfield(
                controller: passwordController,
                hintText: 'Password',
                isObscure: true,
              ),

              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              CustomButton(onPressed: () => login(context), text: 'Login'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 5),
                  SizedBox(
                    child: GestureDetector(
                      onTap: togglePages,
                      child: Text(
                        'Register Here',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
