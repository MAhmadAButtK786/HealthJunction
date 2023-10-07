// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login_form_widget.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: size.height * 0.2,
          alignment: Alignment
              .center, // Center the child widget (image) within the container
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0), // Set border radius here
            child: Image(
              image: AssetImage(tSplashImage),
              fit: BoxFit
                  .cover, // You can adjust the fit property based on your requirements
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          tWelcomeB,
          style: TextStyle(
              color: apptextColor, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          tLogin,
          style: TextStyle(
              color: apptextColor, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
