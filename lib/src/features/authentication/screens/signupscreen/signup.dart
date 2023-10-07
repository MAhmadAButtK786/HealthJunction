// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login_footer_widget.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login_form_widget.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login_header_widget.dart';
import 'package:healthjunction/src/features/authentication/screens/signupscreen/signup_footer_widget.dart';
import 'package:healthjunction/src/features/authentication/screens/signupscreen/signup_form_widget.dart';
import 'package:healthjunction/src/features/authentication/screens/signupscreen/signup_header_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(tDefaultSize),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Section 1
              SignupHeaderWidget(size: size),

              //Section 2 Form
              SignupForm(),

              SignupFooterWidget(),
            ]),
          ),
        ),
      ),
    );
  }
}
