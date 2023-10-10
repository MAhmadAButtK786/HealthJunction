// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unused_import, avoid_print, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';

class ForgetOTP extends StatelessWidget {
  const ForgetOTP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(tDefaultSize),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          tOTP,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold, fontSize: 80.0),
        ),
        Text(
          subTitleOTP.toUpperCase(),
          style:
              GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 40.0,
        ),
        Text(
          "${toOtpMessage} support@code.com",
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20.0,
        ),
        OtpTextField(
          numberOfFields: 6,
          fillColor: Colors.black.withOpacity(0.1),
          filled: true,
          keyboardType: TextInputType.number,
          onSubmit: (code) {
            print("OTP is => $code");
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(tNext),
              style: ElevatedButton.styleFrom(
                backgroundColor: tDarkColor,
              ),
            ))
      ]),
    ));
  }
}
