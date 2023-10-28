// ignore_for_file: body_might_complete_normally_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/features/authentication/models/donor_model.dart';

class DonorRepository extends GetxController {
  static DonorRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  Future<void> createUser(DonorModel donor) async {
    _db
        .collection("Donors")
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
