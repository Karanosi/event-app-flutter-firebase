import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GetUserName extends StatelessWidget {
  //passing the document that i wanna read
  final String documentID;

  const GetUserName({super.key, required this.documentID});

  @override
  Widget build(BuildContext context) {
    //get the collection of document
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      // geting the data of the specified document
      future: users.doc(documentID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text('Email:  ${data['email']}');
        }
        return Row(
          children: const [
            Icon(Icons.wifi_calling),
            Text(
              'Loading..',
            ),
          ],
        );
      }),
    );
  }
}
