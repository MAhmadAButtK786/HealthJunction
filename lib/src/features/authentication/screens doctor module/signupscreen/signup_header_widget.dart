// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login_form_widget.dart';

class DocSignupHeaderWidget extends StatelessWidget {
  const DocSignupHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          tWelcomeTitle,
          style: TextStyle(
              color: apptextColor, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "SignUp as a Doctor",
          style: TextStyle(
              color: apptextColor, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
