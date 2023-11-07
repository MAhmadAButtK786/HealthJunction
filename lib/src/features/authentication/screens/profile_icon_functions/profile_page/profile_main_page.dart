// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/password/password.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/profile_screen/profile_screen.dart';

class ProfileMainPage extends StatelessWidget {
  const ProfileMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    Future<void> _signOut() async {
      await _auth.signOut();
    }

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 69),
          child: Column(
            children: [
              Text(
                "SETTING",
                style: GoogleFonts.montserrat(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: apptextColor),
              ),
              SizedBox(
                height: 55,
              ),
              SizedBox(
                width: 270,
                child: OutlinedButton(
                  onPressed: () {
                    Get.to(() => ProfileScreen());
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.edit, // Choose the icon you want
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width:
                            30, // You can adjust the space between the icon and text
                      ),
                      Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    side: BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 270,
                child: OutlinedButton(
                  onPressed: () {
                    Get.to(() => PasswordChange());
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.fingerprint),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Change Password",
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      side: BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 270,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Setting",
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      side: BorderSide(color: Colors.blue)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 270,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.assignment,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Privacy Policy",
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      )
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      side: BorderSide(color: Colors.blue)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 270,
                child: OutlinedButton(
                  onPressed: () async {
                    await _signOut();
                    Get.to(() => LoginScreen());
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Sign Out",
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      )
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    side: BorderSide(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
