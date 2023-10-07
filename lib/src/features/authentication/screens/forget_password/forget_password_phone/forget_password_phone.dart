// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/forget_password/forget_password_otp/forget_otp.dart';

class ForgetPasswordViaPhone extends StatelessWidget {
  const ForgetPasswordViaPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(60, 35, 45, 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      tFForgetPassword,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      tResetVP,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                        child: Column(children: [
                      TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone_android_outlined),
                              border: OutlineInputBorder(),
                              labelText: tSPhoneNo,
                              hintText: tPhoneNo)),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => const ForgetOTP());
                          },
                          child: Text(tSendOTP),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tDarkColor,
                          ),
                        ),
                      )
                    ]))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
