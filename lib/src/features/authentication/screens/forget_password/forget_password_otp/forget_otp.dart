// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_brace_in_string_interps, sort_child_properties_last, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/dashboard.dart';

class ForgetOTP extends StatelessWidget {
  final String verificationId; // Verification ID received when sending OTP
  String enteredOTP = "";

  ForgetOTP({Key? key, required this.verificationId}) : super(key: key);

  void _verifyOTP(BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: enteredOTP);

      // Sign in the user with the entered OTP
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // OTP verification successful, navigate to the next screen
      if (userCredential.user != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('OTP Verified')));
        // Navigate to the next screen after OTP verification
        Get.to(() => Dashboard());
      }
    } catch (e) {
      // OTP verification failed, display an error message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid OTP. Please try again.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(tDefaultSize),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          tOTP,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold, fontSize: 80.0),
        ),
        Text(
          subTitleOTP.toUpperCase(),
          style:
              GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 40.0,
        ),
        Text(
          "${toOtpMessage} ",
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20.0,
        ),
        OtpTextField(
            numberOfFields: 6,
            fillColor: Colors.black.withOpacity(0.1),
            filled: true,
            keyboardType: TextInputType.number,
            onSubmit: (code) {
              enteredOTP = code;
            }),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _verifyOTP(context);
              },
              child: Text(tNext),
              style: ElevatedButton.styleFrom(
                backgroundColor: tDarkColor,
              ),
            ))
      ]),
    ));
  }
}
