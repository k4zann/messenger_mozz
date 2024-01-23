import 'package:flutter/material.dart';

import '../../widgets/login_button.dart';
import '../../widgets/login_textfield.dart';
import '../login_page/login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

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
                    'Регистрация',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  LoginTextField(controller: _nameController, hintText: "Имя", obscureText: false),
                  const SizedBox(height: 20),
                  LoginTextField(controller: _emailController, hintText: "Email", obscureText: false),
                  const SizedBox(height: 20),
                  LoginTextField(controller: _passwordController, hintText: "Пароль", obscureText: true),
                  const SizedBox(height: 20),
                  LoginTextField(controller: _confirmPasswordController, hintText: "Подтвердите пароль", obscureText: true),
                  const SizedBox(height: 20),
                  LoginButton(
                      onTap: (){

                      },
                      text: 'Зарегистрироваться'
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "У вас уже есть аккаунт?",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          'Войти',
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