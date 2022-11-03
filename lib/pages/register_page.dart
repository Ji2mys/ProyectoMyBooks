import 'package:flutter/material.dart';
import 'package:my_books/pages/login_page.dart';
import 'package:my_books/repositories/users_repository.dart';
import '../models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UsersRepository usersRepository = UsersRepository();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _repeatPass = TextEditingController();
  Gender _gender = Gender.male;
  final Map<String, bool> _userGenres = {
    "fantasy": false,
    "terror": false,
    "scienceFiction": false,
    "adventure": false
  };
  String _userData = "";

  bool _isValidEmail(String? email) {
    if (email != null) {
      if (email.split('@').length == 2 && email.split('@')[1].contains('.')) {
        return true;
      }
    }
    return false;
  }

  void saveUser(User user) async {
    if (_email.text.isEmpty || _pass.text.isEmpty) {
      showSnackBar("Empty fields, try again");
    } else {
      var result = await usersRepository.registerUser(user.email, user.password);
      String msg = "";
      if (result == "invalid-email") {
        msg = "The email is wrong";
      } else if (result == "weak-password") {
        msg = "The password must have 6 characters or more";
      } else if (result == "email-already-in-use") {
        msg = "There is already an account with that email";
      } else if (result == "network-request-failed") {
        msg = "Check your network connection";
      } else {
        msg = "Successful register";
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
        title: const Text('Registration'),
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
                TextFormField(
                  controller: _name,
                  onChanged: (String? text) {
                    setState(() {

                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _email,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) => _isValidEmail(value) ? null : 'Insert a valid email',
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _pass,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _repeatPass,
                  obscureText: true,
                  decoration:
                      const InputDecoration(labelText: 'Repeat Password'),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Male'),
                        leading: Radio<Gender>(
                          groupValue: _gender,
                          value: Gender.male,
                          onChanged: (Gender? value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Female'),
                        leading: Radio<Gender>(
                          groupValue: _gender,
                          value: Gender.female,
                          onChanged: (Gender? value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                CheckboxListTile(
                    title: const Text('Fantasy'),
                    value: _userGenres["fantasy"],
                    selected: _userGenres["fantasy"]!,
                    onChanged: (bool? value) {
                      setState(() {
                        _userGenres["fantasy"] = value!;
                      });
                    }),
                CheckboxListTile(
                    title: const Text('Terror'),
                    value: _userGenres["terror"],
                    selected: _userGenres["terror"]!,
                    onChanged: (bool? value) {
                      setState(() {
                        _userGenres["terror"] = value!;
                      });
                    }),
                CheckboxListTile(
                    title: const Text('Science Fiction'),
                    value: _userGenres["scienceFiction"],
                    selected: _userGenres["scienceFiction"]!,
                    onChanged: (bool? value) {
                      setState(() {
                        _userGenres["scienceFiction"] = value!;
                      });
                    }),
                CheckboxListTile(
                    title: const Text('Adventure'),
                    value: _userGenres["adventure"],
                    selected: _userGenres["adventure"]!,
                    onChanged: (bool? value) {
                      setState(() {
                        _userGenres["adventure"] = value!;
                      });
                    }),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _userData =
                        "Name: ${_name.text}."
                            "\nPassword: ${_pass.text}"
                            "\nRepeat: ${_repeatPass.text}"
                            "\nGenres: $_userGenres."
                            "\nGender: ${_gender.name}.";
                      });
                      if (_pass.text == _repeatPass.text) {
                        User newUser = User(_name.text, _email.text, _pass.text,
                            _gender, _userGenres, DateTime(2000));
                        saveUser(newUser);
                      } else {
                        showSnackBar("Passwords must match");
                      }
                    },
                    child: const Text('Register'),
                  ),
                ),
                Text(_userData)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
