import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth/auth_service.dart';
import '../../widgets/login_button.dart';
import '../../widgets/login_textfield.dart';
import '../home_page/home.dart';
import '../login_page/login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  void register() async {
    if (_formKey.currentState!.validate()) {
      final authService = Provider.of<AuthService>(context, listen: false);

      try {
        authService.register(_nameController.text, _emailController.text, _passwordController.text);

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Заполните все поля'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
              key: _formKey,
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
                    LoginTextField(
                        controller: _nameController,
                        hintText: "Имя",
                        obscureText: false,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Введите имя';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    LoginTextField(
                        controller: _emailController,
                        hintText: "Email",
                        obscureText: false,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Введите email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    LoginTextField(
                        controller: _passwordController,
                        hintText: "Пароль",
                        obscureText: true,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Введите пароль';
                        } else if (value != _confirmPasswordController.text) {
                          return 'Пароли не совпадают';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    LoginTextField(
                      controller: _confirmPasswordController,
                      hintText: "Подтвердите пароль",
                      obscureText: true,
                      validate: (value) {
                        if (value != _passwordController.text) {
                          return 'Пароли не совпадают';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    LoginButton(
                        onTap: (){
                          register();
                        },
                        text: 'Зарегистрироваться'
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
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
          ),
    );
  }
}