import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Hi Mi Comrad !',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          //below is space between the text and form
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              hintText: 'Email',
            ),
          ),
          TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              icon: Icon(Icons.password),
              hintText: 'Password',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: null,
            child: Text('LogIn'),
          ),
          ElevatedButton(
            onPressed: null,
            child: Text('SignIn'),
          ),
        ],
      ),
    );
  }
}
