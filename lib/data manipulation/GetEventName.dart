import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  //passing the document that i wanna read
  final String documentID;

  const GetUserName({super.key, required this.documentID});

  @override
  Widget build(BuildContext context) {
    //get the collection of document
    CollectionReference events =
        FirebaseFirestore.instance.collection('events');

    return FutureBuilder<DocumentSnapshot>(
      // geting the data of the specified document
      future: events.doc(documentID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(68, 124, 77, 255),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  '${data['name']}',
                )
              ],
            ),
          );
        }
        return Row(
          children: const [
            Icon(Icons.view_list),
            Text(
              'Loading..',
            ),
          ],
        );
      }),
    );
  }
}
