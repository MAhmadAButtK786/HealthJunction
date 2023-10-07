// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login_form_widget.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login_header_widget.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
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
              onPressed: () {},
              label: Text(tSGoogle)),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextButton(
          onPressed: () {},
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
