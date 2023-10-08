// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, unnecessary_import
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail.dart';
import 'package:healthjunction/src/features/authentication/screens/forget_password/forget_password_option/forget_password_btn_widget.dart';
import 'package:healthjunction/src/features/authentication/screens/forget_password/forget_password_phone/forget_password_phone.dart';

Future<dynamic> buildShowModelBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      builder: (context) => Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                tForgetSelection,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: tDarkColor),
              ),
              Text(tSelectOption,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: tDarkColor)),
              const SizedBox(
                height: tDefaultSize,
              ),
              ForgetPasswordBtnWidget(
                btnIcon: Icons.mail_outline_outlined,
                subTitle: tResetVE,
                title: tEmail,
                onTap: () {
                  Get.to(() => ForgetPasswordViaEmail());
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              ForgetPasswordBtnWidget(
                btnIcon: Icons.mobile_friendly_rounded,
                subTitle: tResetVP,
                title: tPhoneNo,
                onTap: () {
                  Get.to(() => ForgetPasswordViaPhone());
                },
              ),
            ]),
          ));
}
