import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data manipulation/GetEventName.dart';

class EventsListPage extends StatefulWidget {
  const EventsListPage({super.key});

  @override
  State<EventsListPage> createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  //get user instance
  final user = FirebaseAuth.instance.currentUser!;
  // document id (users id)
  List<String> docIDs = [];
  bool filled = false;
  // fill the user's document id list
  Future getDocId() async {
    if (!filled) {
      filled = !filled;
      await FirebaseFirestore.instance
          .collection('events') // to gegt the events collection
          //.orderBy('email') // this to order by email
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
    );
  }
}
