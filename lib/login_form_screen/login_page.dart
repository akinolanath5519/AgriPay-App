import 'package:flutter/material.dart';
import 'package:jolmonak/login_form_screen/login_form.dart';


class LoginPage extends StatelessWidget {
  final DateTime expiryDate;
  

  const LoginPage({Key? key, required this.expiryDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 178, 32),
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: LoginForm(expiryDate: expiryDate),
      ),
    );
  }
}
