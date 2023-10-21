// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, override_on_non_overriding_member, annotate_overrides, avoid_print, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/dashboard.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login_form_widget.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login_header_widget.dart';
import 'package:healthjunction/src/features/authentication/screens/signupscreen/signup.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  //Firebase Authentication
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Make sure to disconnect any previously signed in account
    await googleSignIn.disconnect();

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              icon: Image(
                image: AssetImage(googleLogo),
                width: 20.0,
              ),
              onPressed: () async {
                UserCredential? userCredential = await signInWithGoogle();
                if (userCredential != null) {
                  print("Sign In SuccessFul");
                  Get.to(() => Dashboard());
                }
              },
              label: Text(tSGoogle)),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextButton(
          onPressed: () {
            Get.to(() => const SignupScreen());
          },
          child: Text.rich(
            TextSpan(
              text: tDonthaveaccount,
              style: TextStyle(color: tDarkColor),
              children: [
                TextSpan(
                  text: tSignup,
                  style: TextStyle(
                    color: apptextColor,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
