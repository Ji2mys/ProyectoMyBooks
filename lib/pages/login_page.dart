import 'package:flutter/material.dart';
import 'package:my_books/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userInput = TextEditingController();
  final _passInput = TextEditingController();
  String _userData = '';

  bool _isValidEmail(String? email) {
    if (email != null) {
      if (email.split('@').length == 2 && email.split('@')[1].contains('.')) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                scale: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                controller: _userInput,
                decoration: const InputDecoration(hintText: 'Email'),
                validator: (String? value) {
                  return _isValidEmail(value) ? null : 'Not valid email';
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passInput,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Password'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value != null) {
                    if (value.length < 8) {
                      return 'Password must have 8 or more characters';
                    } else {
                      return null;
                    }
                  } else {
                    return 'Enter a password';
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _userData =
                          'User: "${_userInput.text}". Pass: "${_passInput.text}".';
                    });
                  },
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  child: const Text("Don't have an account?")),
              Text(_userData)
            ],
          ),
        ),
      ),
    );
  }
}
