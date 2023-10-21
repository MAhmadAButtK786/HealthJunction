// ignore_for_file: unused_import, prefer_const_constructors, sort_child_properties_last, prefer_const_constructors_in_immutables, library_private_types_in_public_api, dead_code, unused_local_variable, avoid_print, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail.dart';
import 'package:healthjunction/src/features/authentication/screens/forget_password/forget_password_otp/forget_otp.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:healthjunction/src/features/authentication/controllers/signup_controller.dart';

class ForgetPasswordViaPhone extends StatefulWidget {
  ForgetPasswordViaPhone({Key? key}) : super(key: key);

  @override
  _ForgetPasswordViaPhoneState createState() => _ForgetPasswordViaPhoneState();
}

class _ForgetPasswordViaPhoneState extends State<ForgetPasswordViaPhone> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _sendOTP() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+92${_phoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) async {
          Get.to(() => ForgetOTP(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e.toString());
    }
  }

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
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    tResetVP,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone_android_outlined),
                            border: OutlineInputBorder(),
                            labelText: tSPhoneNo,
                            hintText: tPhoneNo,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Phone Number';
                            } else if (value.startsWith('+92') &&
                                value.length != 13) {
                              return 'Invalid phone number. Pakistani numbers starting with +92 must have 13 digits.';
                            } else if (!value.startsWith('03') ||
                                value.length != 11) {
                              return 'Invalid phone number. Pakistani mobile numbers must start with 03 and have 11 digits.';
                            }
                            return null; // Validation passed
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
                                    SnackBar(content: Text('Sending OTP...')));
                                _sendOTP();
                              } else {
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
                              Get.to(() => ForgetPasswordViaEmail());
                            },
                            child: Text(tREmail),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: tDarkColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
