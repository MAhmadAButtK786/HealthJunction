import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  final currentPassword = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

//Call this function from Design & it will do the rest
  void registerUser(String email, String password) {}
}
