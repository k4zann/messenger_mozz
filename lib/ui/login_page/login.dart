import 'package:flutter/material.dart';
import 'package:messenger_mozz/widgets/login_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Login Page'),
              const SizedBox(height: 20),
              LoginTextField(controller: _emailController, hintText: "Email", obscureText: false),
              const SizedBox(height: 20),
              LoginTextField(controller: _passwordController, hintText: "Password", obscureText: true),
            ]
          ),
        ),
      )
    );
  }
}