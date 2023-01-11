import 'package:events_app/pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AuthPage.dart';

// this one checks if the user is autheticated or not
class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home(title: 'Events');
          } else {
            // it ll show either the login page or the register page
            return AuthPage();
          }
        },
      ),
    );
  }
}
