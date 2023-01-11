import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    super.key,
    required this.showLoginPage,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final _emailcontroller = TextEditingController();
  final _pwdcontroller = TextEditingController();
  final _confirmpwdcontroller = TextEditingController();

  // this method is for memory management
  @override
  void dispose() {
    _emailcontroller.dispose();
    _pwdcontroller.dispose();
    _confirmpwdcontroller.dispose();
    super.dispose();
  }

  Future signup() async {
    if (confirmedPwd()) {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _pwdcontroller.text.trim(),
      );
    }
  }

  // checking if the two passwords match
  bool confirmedPwd() {
    if (_pwdcontroller.text.trim() == _confirmpwdcontroller.text.trim()) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create your account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  //below is space between the text and form
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _emailcontroller,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _pwdcontroller,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _confirmpwdcontroller,
                    decoration: const InputDecoration(
                      hintText: 'confirm password',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: signup,
                    child: const Text('Register'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: widget.showLoginPage,
                    child: const Text('Back to login page '),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
