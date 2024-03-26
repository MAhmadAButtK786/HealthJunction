

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import "package:healthjunction/src/constants/sizes.dart";
import 'package:healthjunction/src/features/authentication/screens%20doctor%20module/signupscreen/signup_footer_widget.dart';
import 'package:healthjunction/src/features/authentication/screens%20doctor%20module/signupscreen/signup_form_widget.dart';
import 'package:healthjunction/src/features/authentication/screens%20doctor%20module/signupscreen/signup_header_widget.dart';

class DocSignupScreen extends StatelessWidget {
  const DocSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(tDefaultSize),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1
                    DocSignupHeaderWidget(size: size),

                    //Section 2 Form
                    DocSignupForm(),

                    const DocSignupFooterWidget(),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
