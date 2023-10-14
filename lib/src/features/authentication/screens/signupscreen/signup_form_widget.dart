// ignore_for_file: prefer_const_constructors, unused_import, avoid_print, use_key_in_widget_constructors, unused_local_variable, unused_element, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/controllers/signup_controller.dart';
import 'package:healthjunction/src/features/authentication/screens/home_screen/home_screen.dart';

class SignupForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('User signed up: ${userCredential.user!.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Failed to sign up: $e');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            //Username

            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                border: OutlineInputBorder(),
                labelText: 'Username',
                hintText: 'Enter your username',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Username.';
                }
                if (value.length < 6) {
                  return 'Username should contain atleast 8 letters';
                }
// Regular expression for validating a Username (alphanumeric characters only)
                String usernameRegex = r'^[a-zA-Z0-9]';
                RegExp usernameRegExp = RegExp(usernameRegex);

                if (!usernameRegExp.hasMatch(value)) {
                  return 'Enter a valid email address or username.';
                }

                return null; // Return null if the input is valid
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            //Email
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail),
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email.';
                }

                // Regular expression for validating an Email
                // You can use a more comprehensive regex for stricter validation
                String emailRegex = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                RegExp emailRegExp = RegExp(emailRegex);
                if (!emailRegExp.hasMatch(value)) {
                  return 'Enter a valid email address or username.';
                }

                return null; // Return null if the input is valid
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            //Phone
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Your Phone Number';
                } else if (value.startsWith('+92') && value.length != 13) {
                  return 'Invalid phone number. Pakistani numbers starting with +92 must have 13 digits.';
                } else if (!value.startsWith('03') || value.length != 11) {
                  return 'Invalid phone number. Pakistani mobile numbers must start with 03 and have 11 digits.';
                }
                return null; // Validation passed
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            //Password
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                  )),
              //Password Validation Start
              validator: (value) {
                //Check is password is filled
                if (value!.isEmpty) {
                  return 'Please Enter your password.';
                }
                //Check Password Length
                if (value.length < 8) {
                  return 'Please Must be at least 8 Characters';
                }
                //Check Password has uppercase letter
                if (!value.contains(RegExp(r'[A-Z]'))) {
                  return 'Password must have at least one Uppercase letter';
                }
                //Check Password has Lowercase letter
                if (!value.contains(RegExp(r'[a-z]'))) {
                  return 'Password must have at least one Lowercase letter ';
                }
                //Check Password has Special Character
                if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                  return 'Password must have at leat one Special Character';
                }
                //Check Password has numbers
                if (!value.contains(RegExp(r'[0-9]'))) {
                  return 'Password must have at least one number';
                }
                return null; // Return null if the input is valid
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            //Confirm Password
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter your password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                    icon: Icon(_isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                  )),
              //Password Validation Start
              validator: (value) {
                //Check is password is filled
                if (value!.isEmpty) {
                  return 'Please Enter your password.';
                }
                //Check Password Length
                if (value.length < 8) {
                  return 'Please Must be at least 8 Characters';
                }
                //Check Password has uppercase letter
                if (!value.contains(RegExp(r'[A-Z]'))) {
                  return 'Password must have at least one Uppercase letter';
                }
                //Check Password has Lowercase letter
                if (!value.contains(RegExp(r'[a-z]'))) {
                  return 'Password must have at least one Lowercase letter ';
                }
                //Check Password has Special Character
                if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                  return 'Password must have at leat one Special Character';
                }
                //Check Password has numbers
                if (!value.contains(RegExp(r'[0-9]'))) {
                  return 'Password must have at least one number';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match.';
                }
                return null; // Return null if the input is valid
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _signUp(); // Call the signup function here
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Signing up...')));
                    Get.to(() => const HomeScreen());
                  } else {
                    // Authentication failed, display an error message to the user
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Authentication Failed')));
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                child: Text('Signup'.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
