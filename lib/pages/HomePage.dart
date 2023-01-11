import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data manipulation/GetUserName.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // document id (users id)
  List<String> docIDs = [];
  bool filled = false;
  // fill the user's document id list
  Future getDocId() async {
    if (!filled) {
      filled = !filled;
      await FirebaseFirestore.instance
          .collection('users') // to gegt the user collection
          .orderBy('email') // this to order by email
          .get()
          .then(
        (snapshot) {
          snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          });
        },
      );
    }
  }

  int _index = 0;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          GestureDetector(
            child: const Icon(Icons.logout),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You are in the home Page !'),
            Text('Your email is ${user.email!}'),
            Expanded(
              child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: GetUserName(
                            documentID: docIDs[index],
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Color.fromARGB(5, 0, 0, 0),
        color: Colors.black,
        items: const <Widget>[
          Icon(Icons.home),
          Icon(Icons.add),
          Icon(Icons.list),
          Icon(Icons.account_box),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
    );
  }
}
