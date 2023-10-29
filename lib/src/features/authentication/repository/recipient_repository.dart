// ignore_for_file: prefer_const_constructors, body_might_complete_normally_catch_error, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/features/authentication/models/recipient_model.dart';

class RecipientRepository extends GetxController {
  static RecipientRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  // ... existing code ...
  Future<void> createUser(RecepientModel recipient) async {
    var emailExists = await _db
        .collection("Recepients")
        .where("email", isEqualTo: recipient.email)
        .get();

    var phoneExists = await _db
        .collection("Recepients")
        .where("phone", isEqualTo: recipient.phoneNumber)
        .get();

    if (emailExists.docs.isNotEmpty) {
      // Email already exists
      Get.snackbar(
        "Failed",
        "Email is already registered.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.redAccent,
      );
    } else if (phoneExists.docs.isNotEmpty) {
      // Phone number already exists
      Get.snackbar(
        "Failed",
        "Phone number is already registered.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.redAccent,
      );
    } else {
      // Email and phone number are unique, add the recipient
      await _db
          .collection("Recepients")
          .add(recipient.toJason())
          .then((value) => Get.snackbar("Success", "You are added as Recepient",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green))
          .catchError((error) {
        Get.snackbar(
          "Failed",
          "Failed to add you as a Recepient",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.redAccent,
        );
      });
    }
  }
}
