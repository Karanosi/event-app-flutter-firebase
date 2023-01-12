import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final _firstNamecontroller = TextEditingController();
  final _lastNamecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _citycontroller = TextEditingController();

  // to store the image url
  String imageUrl = ' ';

  // this method is for memory management
  @override
  void dispose() {
    _emailcontroller.dispose();
    _pwdcontroller.dispose();
    _confirmpwdcontroller.dispose();
    _firstNamecontroller.dispose();
    _lastNamecontroller.dispose();
    _agecontroller.dispose();
    _citycontroller.dispose();
    super.dispose();
  }

  Future signup() async {
    if (confirmedPwd()) {
      // create user
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _pwdcontroller.text.trim(),
      );
      // calling adduserdetails method
      addUserDetails(
        imageUrl.toString(),
        _firstNamecontroller.text.trim(),
        _lastNamecontroller.text.trim(),
        int.parse(_agecontroller.text.trim()),
        _citycontroller.text.trim(),
        _emailcontroller.text.trim(),
      );
    }
  }

  Future addUserDetails(String image, String firstName, String lastName,
      int age, String city, String email) async {
    // connect with firebase database and access the user collecion
    await FirebaseFirestore.instance.collection('users').add({
      'image': image,
      'first name': firstName,
      'last name': lastName,
      'age': age,
      'city': city,
      'email': email,
    });
  }

  // function to add user details

  // checking if the two passwords match
  bool confirmedPwd() {
    if (_pwdcontroller.text.trim() == _confirmpwdcontroller.text.trim()) {
      return true;
    }
    return false;
  }

  // method to pick and upload image
  void pickUploadImage() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    // creating a reference
    try {
      Reference ref = FirebaseStorage.instance.ref().child('images/');
      await ref.putFile(File(image!.path));
      ref.getDownloadURL().then((value) {
        print(value);
        //refresh to display the image
        setState(() {
          imageUrl = value.toString();
        });
      });
    } on FirebaseException catch (e) {
      print(
        e.toString(),
      );
    }
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
                  // image input
                  SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: GestureDetector(
                      onTap: () {
                        pickUploadImage();
                      },
                      // showing either the image ir the icon
                      child: imageUrl == ' '
                          ? const Icon(
                              Icons.image_search_rounded,
                              size: 100,
                            )
                          : Image.network(imageUrl),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // first name textfirld
                  TextField(
                    controller: _firstNamecontroller,
                    decoration: const InputDecoration(
                      hintText: 'First Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // last name textfirld
                  TextField(
                    controller: _lastNamecontroller,
                    decoration: const InputDecoration(
                      hintText: 'Last Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // age textfirld
                  TextField(
                    controller: _agecontroller,
                    decoration: const InputDecoration(
                      hintText: 'Age',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // city textfirld => to change into DropdownButton
                  TextField(
                    controller: _citycontroller,
                    decoration: const InputDecoration(
                      hintText: 'City',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // email textfirld
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
                      hintText: 'Confirm Password',
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
