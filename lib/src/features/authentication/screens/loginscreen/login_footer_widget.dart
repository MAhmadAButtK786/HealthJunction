// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, override_on_non_overriding_member, annotate_overrides, avoid_print, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/dashboard.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login_form_widget.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login_header_widget.dart';
import 'package:healthjunction/src/features/authentication/screens/signupscreen/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

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
      print("Sign in successful");
      // Sign in with Firebase using the Google credentials
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Access user details
      String? email = userCredential.user!.email;
      String id = userCredential.user!.uid;
      String? fullName = userCredential.user!.displayName;
      String? password = '';
      String? phoneNumber = '';
      // Store user data in Firestore
      await FirebaseFirestore.instance.collection('Users').doc(id).set({
        'id': id,
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
      });

      return userCredential;
    } catch (e) {
      // Handle any errors that occur during the sign-in process
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("OR"),
          SizedBox(
            height: 10,
          ),
          Text(
            "Sign Up with",
            style: GoogleFonts.montserrat(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 7,
          ),
          SizedBox(
            height: 50,
            width: 150,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Google Button
                  IconButton(
                    icon: Image(
                      image: AssetImage(googleLogo),
                      width: 23.0,
                    ),
                    onPressed: () async {
                      UserCredential? userCredential = await signInWithGoogle();
                      if (userCredential != null) {
                        // User signed in successfully, you can handle the user data here
                        print(
                            'User signed in with Google: ${userCredential.user}');
                        Get.to(() => Dashboard()); // Navigate to Dashboard
                      }
                    },
                  ),

                  //Facebook Button

                  IconButton(
                    icon: Image(
                      image: AssetImage(facbook),
                      width: 30.0,
                    ),
                    onPressed: () async {
                      UserCredential? userCredential = await signInWithGoogle();
                      if (userCredential != null) {
                        // User signed in successfully, you can handle the user data here
                        print(
                            'User signed in with Facebook: ${userCredential.user}');
                        Get.to(() => Dashboard()); // Navigate to Dashboard
                      }
                    },
                  ),
                  //X(Twitter) Button

                  IconButton(
                    icon: Image(
                      image: AssetImage(twitterX),
                      width: 30.0,
                    ),
                    onPressed: () async {
                      UserCredential? userCredential = await signInWithGoogle();
                      if (userCredential != null) {
                        // User signed in successfully, you can handle the user data here
                        print('User signed in with X: ${userCredential.user}');
                        Get.to(() => Dashboard()); // Navigate to Dashboard
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.to(() => SignupScreen());
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
      ),
    );
  }
}
