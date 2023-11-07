// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors, unused_import, unused_local_variable, prefer_const_constructors_in_immutables, unused_field, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/features/authentication/screens/ambullance/ambullance.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/BloodBankHome.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/dashboard.dart';
import 'package:healthjunction/src/features/authentication/screens/emergency/emergency.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthjunction/src/features/authentication/controllers/signup_controller.dart';

class ReusableDrawerSideBar extends StatelessWidget {
  final Color color;
  final String headerText;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ReusableDrawerSideBar({required this.color, required this.headerText});

  Future<void> _signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 150,
            child: DrawerHeader(
              padding: EdgeInsets.only(top: 35, left: 12),
              child: Text(
                headerText,
                style: GoogleFonts.inter(
                    color: tWhiteColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                color: color,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              LineAwesomeIcons.ambulance,
              color: color,
            ),
            title: Text(
              'Ambulance',
              style:
                  GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => Ambulance());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: color,
            ),
            title: Text(
              'Information',
              style:
                  GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => ());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.emergency,
              color: color,
            ),
            title: Text(
              'Emergency Contacts',
              style:
                  GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => Emergency());
            },
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.logout,
          //     color: color,
          //   ),
          //   title: Text(
          //     'LogOut',
          //     style:
          //         GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
          //   ),
          //   onTap: () async {
          //     controller.emailController.clear();
          //     controller.passwordController.clear();

          //     await _signOut();
          //     Get.to(() => LoginScreen());
          //   },
          // ),
        ],
      ),
    );
  }
}
