// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_import, unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthjunction/firebase_options.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/administratiion/basichealthdata.dart';
import 'package:healthjunction/src/features/authentication/administratiion/bbprivate.dart';
import 'package:healthjunction/src/features/authentication/administratiion/bbpublic.dart';
import 'package:healthjunction/src/features/authentication/repository/donor_repository.dart';
import 'package:healthjunction/src/features/authentication/repository/recipient_repository.dart';
import 'package:healthjunction/src/features/authentication/repository/user_repository.dart';
import 'package:healthjunction/src/features/authentication/screens/bloodbank/blooddonor/donor_form/donor_form.dart';
import 'package:healthjunction/src/features/authentication/screens/bloodbank/blooddonor/donor_search/donor_search.dart';
import 'package:healthjunction/src/features/authentication/screens/bloodbank/bloodrecipent/recipient_form.dart';
import 'package:healthjunction/src/features/authentication/screens/bloodbank/bloodrecipent/search_recipient.dart';
import 'package:healthjunction/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail.dart';
import 'package:healthjunction/src/features/authentication/screens/forget_password/forget_password_phone/forget_password_phone.dart';
import 'package:healthjunction/src/features/authentication/screens/loginscreen/login.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_screen/profile_screen.dart';
import 'package:healthjunction/src/features/authentication/screens/signupscreen/signup.dart';
import 'package:healthjunction/src/features/authentication/screens/welcome/welcome.dart';
import 'package:healthjunction/src/utils/theme/theme.dart';
import 'package:healthjunction/src/utils/theme/theme.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize for the Firebase
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // add plateform

  // Add this line to put UserRepository instance to GetX
  Get.put(UserRepository());
  Get.put(RecipientRepository());
  Get.put(DonorRepository());
  runApp(HealthJunction());
}

class HealthJunction extends StatelessWidget {
  const HealthJunction({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()), // Login Screen
        GetPage(name: '/signup', page: () => SignupScreen()), //Sign-up Screen
        GetPage(
            name: '/Forget-Mail',
            page: () => ForgetPasswordViaEmail()), // Mail OTP SEND
        GetPage(
            name: '/Forget-Phone',
            page: () => ForgetPasswordViaPhone()), //Phone OTP SEND
      ],
      title: 'Health Junction',
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      //home: Welcome(),
      home: BasicHealthInfo(),
    );
  }
}
