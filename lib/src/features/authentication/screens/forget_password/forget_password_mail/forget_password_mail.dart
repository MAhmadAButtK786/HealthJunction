// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/forget_password/forget_password_otp/forget_otp.dart';
import 'package:healthjunction/src/features/authentication/screens/forget_password/forget_password_phone/forget_password_phone.dart';

class ForgetPasswordViaEmail extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(60, 35, 45, 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      tFForgetPassword,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      tResetVE,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(children: [
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail_outline_rounded),
                                border: OutlineInputBorder(),
                                labelText: tSEmail,
                                hintText: tEmail),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email.';
                              }

                              // Regular expression for validating an Email
                              // You can use a more comprehensive regex for stricter validation
                              String emailRegex =
                                  r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                              RegExp emailRegExp = RegExp(emailRegex);
                              if (!emailRegExp.hasMatch(value)) {
                                return 'Enter a valid email address or username.';
                              }

                              return null; // Return null if the input is valid
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Login Successful')));
                                  Get.to(() => ForgetOTP());
                                } else {
                                  // Authentication failed, display an error message to the user
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Wrong Input')));
                                }
                              },
                              child: Text(tSendOTP),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: tDarkColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Get.to(() => ForgetPasswordViaPhone());
                              },
                              child: Text(tRPhone),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: tDarkColor,
                              ),
                            ),
                          )
                        ]))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
