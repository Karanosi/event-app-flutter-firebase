import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventAddPage extends StatefulWidget {
  const EventAddPage({super.key});

  @override
  State<EventAddPage> createState() => _EventAddPageState();
}

class _EventAddPageState extends State<EventAddPage> {
  //text controllers
  final _namecontroller = TextEditingController();
  final _typecontroller = TextEditingController();
  final _datecontroller = TextEditingController();
  final _timecontroller = TextEditingController();
  final _citycontroller = TextEditingController();

  // this method is for memory management
  @override
  void dispose() {
    _namecontroller.dispose();
    _typecontroller.dispose();
    _datecontroller.dispose();
    _timecontroller.dispose();
    _citycontroller.dispose();
    super.dispose();
  }

  final user = FirebaseAuth.instance.currentUser!;
  Future addEvent() async {
    // create user
    // calling adduserdetails method

    addEventDetails(
      _namecontroller.text.trim(),
      _typecontroller.text.trim(),
      _citycontroller.text.trim(),
      _datecontroller.text.trim(),
      _timecontroller.text.trim(),
      user.email.toString().trim(),
    );
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            icon: Icon(Icons.add),
            content: Text('Event Added !'),
          );
        });
    _namecontroller.text = '';
    _typecontroller.text = '';
    _citycontroller.text = '';
    _datecontroller.text = '';
    _timecontroller.text = '';
  }

  Future addEventDetails(String name, String type, String city, String date,
      String time, String email) async {
    // connect with firebase database and access the user collecion
    await FirebaseFirestore.instance.collection('events').add({
      'name': name,
      'type': type,
      'city': city,
      'date': date,
      'time': time,
      'email': email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create your Event !',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                //below is space between the text and form
                const SizedBox(
                  height: 20,
                ),
                // event name textfirld
                TextField(
                  controller: _namecontroller,
                  decoration: const InputDecoration(
                    hintText: 'Event Name',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // event type textfirld
                TextField(
                  controller: _typecontroller,
                  decoration: const InputDecoration(
                    hintText: 'Event Type',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // city textfirld
                TextField(
                  controller: _citycontroller,
                  decoration: const InputDecoration(
                    hintText: 'Event City',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // city textfirld => to change into DropdownButton
                TextField(
                  controller: _datecontroller,
                  decoration: const InputDecoration(
                    hintText: 'Event Date',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // email textfirld
                TextField(
                  controller: _timecontroller,
                  decoration: const InputDecoration(
                    hintText: 'Event Time starts at',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: addEvent,
                  child: Row(
                    children: const [
                      Icon(Icons.add),
                      Text('Add'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
