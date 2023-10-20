// ignore_for_file: prefer_const_constructors, unused_import, avoid_print, use_key_in_widget_constructors, unused_local_variable, unused_element, unused_field, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/controllers/signup_controller.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/dashboard.dart';

class SignupForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  // Firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _registerUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.to(() => Dashboard());
    } on FirebaseAuthException catch (e) {
      print('Failed to register user: ${e.message}');
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage =
              'The email address is already in use. Please use a different one.';
          break;
        case 'phone-number-already-exists':
          errorMessage =
              'The phone number is already in use. Please use a different one.';
          break;
        case 'credential-already-in-use':
          errorMessage =
              'The email address or phone number is already in use. Please use a different one.';
          break;
        default:
          errorMessage = e.message ?? 'An error occurred during registration.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            //Username

            TextFormField(
              controller: controller.usernameController,
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
                  return 'Enter a valid Username.';
                }

                return null; // Return null if the input is valid
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            //Email
            TextFormField(
              controller: controller.emailController,
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
                  return 'Enter a valid email address';
                }

                return null; // Return null if the input is valid
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            //Phone
            TextFormField(
              controller: controller.phoneController,
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
              controller: controller.passwordController,
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
              controller: controller.confirmPasswordController,
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
                if (value != controller.passwordController.text) {
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
                    _registerUserWithEmailAndPassword(
                        controller.emailController.text.trim(),
                        controller.confirmPasswordController.text.trim());
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
