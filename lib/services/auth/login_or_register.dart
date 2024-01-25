import 'package:flutter/material.dart';
import 'package:messenger_mozz/ui/registration_page/registration.dart';

import '../../ui/login_page/login.dart';

class LoginOrRegister extends StatefulWidget{
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool showLoginPage = true;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onPressed: togglePage,);
    } else {
      return RegistrationPage(onPressed: togglePage,);
    }
  }
}
