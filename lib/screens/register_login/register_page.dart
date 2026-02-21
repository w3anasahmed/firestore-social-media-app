import 'package:flutter/material.dart';
import 'package:social_app/components/custom_button.dart';
import 'package:social_app/components/custom_textfield.dart';
import 'package:social_app/services/auth/auth_serivce.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? togglePages;
  RegisterPage({super.key, required this.togglePages});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final AuthSerivce authSerivce = AuthSerivce();

  void register(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Passwords do not match!')));
      return;
    } else if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill all the fields!')));
      return;
    } else {
      try {
        await AuthSerivce().registerWithEmailAndPassword(
          emailController.text,
          passwordController.text,
          usernameController.text,
        );
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Registered successfully!')));
        }
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
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
                controller: usernameController,
                hintText: 'Username',
                isObscure: false,
              ),
              SizedBox(height: 15),
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
              SizedBox(height: 15),
              CustomTextfield(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                isObscure: true,
              ),
              SizedBox(height: 30),
              CustomButton(
                onPressed: () => register(context),
                text: 'Register',
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: togglePages,
                    child: Text(
                      'Login Here',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
