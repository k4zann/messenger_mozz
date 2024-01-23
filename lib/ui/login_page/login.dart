import 'package:flutter/material.dart';
import 'package:messenger_mozz/services/auth_service.dart';
import 'package:messenger_mozz/widgets/login_button.dart';
import 'package:messenger_mozz/widgets/login_textfield.dart';
import 'package:provider/provider.dart';

import '../home_page/home.dart';
import '../registration_page/registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  void login() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.login(_emailController.text, _passwordController.text);
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

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
              const Text(
                'Вход',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              LoginTextField(controller: _emailController, hintText: "Email", obscureText: false),
              const SizedBox(height: 20),
              LoginTextField(controller: _passwordController, hintText: "Password", obscureText: true),
              const SizedBox(height: 20),
              LoginButton(
                onTap: (){
                  login();
                },
                text: 'Войти'
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "У вас нет аккаунта?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => RegistrationPage()),
                          (route) => false
                      );
                    },
                    child: Text(
                      'Зарегистрироваться',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ]
          ),
        ),
      )
    );
  }
}