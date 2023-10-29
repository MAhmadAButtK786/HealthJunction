// ignore_for_file: body_might_complete_normally_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/features/authentication/models/donor_model.dart';

class DonorRepository extends GetxController {
  static DonorRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  Future<void> createUser(DonorModel donor) async {
    var donors = _db.collection("Donors");

    // Check if the email or phone number already exists
    var existingUsers =
        await donors.where('email', isEqualTo: donor.email).get();
    if (existingUsers.docs.isNotEmpty) {
      Get.snackbar(
        "Error",
        "Email already exists",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.redAccent,
      );
      return;
    }

    existingUsers =
        await donors.where('phone', isEqualTo: donor.phoneNumber).get();
    if (existingUsers.docs.isNotEmpty) {
      Get.snackbar(
        "Error",
        "Phone number already exists",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.redAccent,
      );
      return;
    }

    // If not, create the user
    await donors
        .add(donor.toJason())
        .then((value) => Get.snackbar(
              "Success",
              "You are registered as Donor",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green,
            ))
        .catchError((error) {
      Get.snackbar("Failed", "Failed to Register you as Donor",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.redAccent);
    });
  }
}
