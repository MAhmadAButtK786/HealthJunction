// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors

import "package:flutter/material.dart";
import "package:healthjunction/src/constants/colors.dart";
import "package:healthjunction/src/constants/sizes.dart";
import "package:healthjunction/src/constants/text_string.dart";
import "package:healthjunction/src/features/authentication/screens/forget_password/forget_password_option/forget_password_model_bottom_sheet.dart";

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            //Email
            TextFormField(
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

                // Regular expression for validating an Email
                // You can use a more comprehensive regex for stricter validation
                String emailRegex = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                RegExp emailRegExp = RegExp(emailRegex);

// Regular expression for validating a Username (alphanumeric characters only)
                String usernameRegex = r'^[a-zA-Z0-9]';
                RegExp usernameRegExp = RegExp(usernameRegex);

                if (!emailRegExp.hasMatch(value) &&
                    !usernameRegExp.hasMatch(value)) {
                  return 'Enter a valid email address or username.';
                }
                if (usernameRegex.length < 6) {
                  return 'Enter Valid Username';
                }
                return null; // Return null if the input is valid
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              focusNode: _passwordFocusNode,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: tPassword,
                  hintText: tLPassword,
                  suffixIcon: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.remove_red_eye_sharp),
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
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login Successful')));
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
                  padding: EdgeInsets.symmetric(vertical: tButtonHeight),
                  foregroundColor: tWhiteColor,
                  backgroundColor: apptextColor,
                ),
                child: Text(tLogin.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
