// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, use_build_context_synchronously, avoid_print

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:healthjunction/src/constants/colors.dart";
import "package:healthjunction/src/constants/sizes.dart";
import "package:healthjunction/src/constants/text_string.dart";
import "package:healthjunction/src/features/authentication/controllers/signup_controller.dart";
import "package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/dashboard.dart";
import "package:healthjunction/src/features/authentication/screens/forget_password/forget_password_option/forget_password_model_bottom_sheet.dart";

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

// Firebase Authentication
  Future<void> _signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login Successful')));
        Get.to(() => Dashboard());
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Failed to Login: User Not Found';
          break;
        case 'wrong-password':
          errorMessage = 'Failed to Login: Incorrect Password';
          break;
        default:
          errorMessage = 'Invalid Email/Password';
          break;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred.')));
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
            //Email
            TextFormField(
              controller: controller.emailController,
              focusNode: _emailFocusNode,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: tUsernameEmail,
                hintText: tLUsername,
              ),
              // Email Validation
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email.';
                }
                String emailRegex = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                RegExp emailRegExp = RegExp(emailRegex);
                if (!emailRegExp.hasMatch(value)) {
                  return 'Enter a valid email address or username.';
                }

                return null; // Return null if the input is valid
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            // Password
            TextFormField(
              controller: controller.passwordController,
              focusNode: _passwordFocusNode,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: tPassword,
                hintText: tLPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: Icon(_isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
              // Password Validation Start
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter your password.';
                }
                if (value.length < 8) {
                  return 'Password Must be at least 8 Characters';
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
              height: 10.0,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  buildShowModelBottomSheet(context);
                },
                child: Text(
                  tLForget,
                  style: TextStyle(
                    color: apptextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _signIn(controller.emailController.text.trim(),
                        controller.passwordController.text.trim());
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: tButtonHeight),
                  foregroundColor: tWhiteColor,
                  backgroundColor: apptextColor,
                ),
                child: Text(tLogin.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
