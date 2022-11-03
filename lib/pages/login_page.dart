import 'package:flutter/material.dart';
import 'package:my_books/main.dart';
import 'package:my_books/pages/register_page.dart';
import 'package:my_books/repositories/users_repository.dart';

import '../models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usersRepository = UsersRepository();
  final _userInput = TextEditingController();
  final _passInput = TextEditingController();
  String _userData = '';
  User appUser = User("Karl", "karl@gmail.com", "karlkarlkarlkarl", Gender.male, {"fantasy":true, "terror":false, "scienceFiction":true, "adventure":true}, DateTime(2000));

  bool _isValidEmail(String? email) {
    if (email != null) {
      if (email.split('@').length == 2 && email.split('@')[1].contains('.')) {
        return true;
      }
    }
    return false;
  }

  void _validateUser() async {
    if (_userInput.text.isEmpty || _passInput.text.isEmpty) {
      showSnackBar("You must enter email and password");
    } else {
      var result = await usersRepository.loginUser(_userInput.text, _passInput.text);
      String msg = "";
      if (result == "invalid-email") {
        msg = "Invalid email";
      } else if (result == "wrong-password") {
        msg = "Wrong email or password";
      } else if (result == "network-request-failed") {
        msg = "Check your network connection";
      } else if (result == "user-not-found") {
        msg = "There is no user with that email";
      } else {
        msg = "Welcome";
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: "Home Page")));
      }
      showSnackBar(msg);
    }
  }

  void showSnackBar(String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
        SnackBar(
          content: Text(message),
          action: SnackBarAction(
            label: "Close",
            onPressed: () => scaffold.hideCurrentSnackBar(),
          ),
          duration: const Duration(seconds: 10),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
        child: SingleChildScrollView(
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
                            'User: "${_userInput.text}". Pass: "${_passInput.text}". Valid: ${_userInput.text == appUser.email && _passInput.text == appUser.password}.';
                      });
                      _validateUser();
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
      ),
    );
  }
}
