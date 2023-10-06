// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/text_string.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(children: [
        Image(image: AssetImage(tSplashImage)),
        Text(
          tWelcomeTitle,
          style: TextStyle(color: apptextColor),
        ),
        Text(
          tDescriptionText,
          style: TextStyle(color: apptextColor),
        ),
        Row(
          children: [
            OutlinedButton(onPressed: () {}, child: Text(tLogin)),
            ElevatedButton(onPressed: () {}, child: Text(tSignup)),
          ],
        )
      ]),
    ));
  }
}
