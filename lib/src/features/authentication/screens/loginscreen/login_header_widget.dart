// ignore_for_file: prefer_const_constructors

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: const AssetImage(tSplashImage),
          height: size.height * 0.2,
        ),
        Text(
          tWelcomeB,
          style: TextStyle(color: apptextColor, fontWeight: FontWeight.bold),
        ),
        Text(
          tLogin,
          style: TextStyle(color: apptextColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
