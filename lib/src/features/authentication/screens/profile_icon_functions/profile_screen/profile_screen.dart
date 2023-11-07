// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthjunction/src/features/authentication/models/user_model.dart';
import 'package:healthjunction/src/features/authentication/repository/user_repository.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final FirebaseFirestore _db =
      FirebaseFirestore.instance; // Define _db variable here
  Future<UserModel> getCurrentUser([String? userId]) async {
    var userDoc = await _db
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    // Check if the document exists
    if (userDoc.exists) {
      // Get the document data as a map
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      // Access fields from the userData map, provide default values if fields don't exist
      UserModel user = UserModel(
        id: userDoc.id,
        fullName: userData['fullName'] ??
            '', // Provide a default value if 'fullName' does not exist
        email: userData['email'] ??
            '', // Provide a default value if 'email' does not exist
        phoneNumber: userData['phoneNumber'] ??
            '', // Provide a default value if 'phoneNumber' does not exist
        password: userData['password'] ??
            '', // Provide a default value if 'password' does not exist
      );

      return user;
    } else {
      throw Exception("User document does not exist");
    }
  }

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
      ),
      backgroundColor: Colors.lightBlue[100],
      body: FutureBuilder<UserModel>(
        future: UserRepository.instance.getCurrentUser(userId),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            UserModel user = snapshot.data!;
            _fullNameController.text = user.fullName;
            _emailController.text = user.email;
            _phoneNumberController.text = user.phoneNumber;

            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Edit Your Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text('Save Changes'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Save the form state
                          _formKey.currentState!.save();

                          // Fetch the current user data
                          UserModel oldUser =
                              await UserRepository.instance.getCurrentUser();

                          // Create a new UserModel instance with the updated information
                          UserModel updatedUser = UserModel(
                            id: oldUser.id,
                            fullName: _fullNameController.text,
                            email: _emailController.text,
                            phoneNumber: _phoneNumberController.text,
                            password: oldUser.password, // Keep the old password
                          );

                          UserRepository.instance
                              .updateUser(oldUser, updatedUser);

                          // Show a success dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Success'),
                                content: Text('Your profile has been updated!'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
