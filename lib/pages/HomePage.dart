import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'PageTree.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> titleList = [
    'Events List',
    'Add Event',
    'My Events',
    'My Account'
  ];
  String title = 'Events List';

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          GestureDetector(
            child: const Icon(Icons.logout),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Container(
        child: PageTree(
          index: _index,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Color.fromARGB(5, 0, 0, 0),
        color: Colors.deepPurple,
        items: const <Widget>[
          Icon(Icons.home),
          Icon(Icons.add),
          Icon(Icons.list),
          Icon(Icons.account_box),
        ],
        onTap: (index) {
          //Handle button tap
          setState(() {
            title = titleList[index];
            _index = index;
          });
        },
      ),
    );
  }
}
