// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, avoid_print, override_on_non_overriding_member, annotate_overrides

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/dashboard.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login_form_widget.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login_header_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healthjunction/src/features/authentication/screens/signupscreen/signup.dart';

class SignupFooterWidget extends StatelessWidget {
  const SignupFooterWidget({Key? key}) : super(key: key);

  @override
  //Google Sign in Authentication
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      // Sign out any previous user
      await googleSignIn.signOut();

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // If the user cancels the sign-in process, return null
      if (googleUser == null) {
        print('User cancelled the sign-in process');
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase using the Google credentials
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Handle any errors that occur during the sign-in process
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "OR",
          style: TextStyle(color: apptextColor),
        ),
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
                  // User signed in successfully, you can handle the user data here
                  print('User signed in with Google: ${userCredential.user}');
                  Get.to(() => Dashboard()); // Navigate to Dashboard
                }
              },
              label: Text(tSGoogle)),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextButton(
          onPressed: () {
            Get.to(() => const LoginScreen());
          },
          child: Text.rich(
            TextSpan(
              text: tAAccount,
              style: TextStyle(color: tDarkColor),
              children: [
                TextSpan(
                  text: tLogin,
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
