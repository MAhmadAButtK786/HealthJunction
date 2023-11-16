// ignore_for_file: prefer_const_constructors, body_might_complete_normally_catch_error, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/features/authentication/models/recipient_model.dart';

class RecipientRepository extends GetxController {
  static RecipientRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  // ... existing code ...
  Future<void> createUser(RecepientModel donor) async {
    _db
        .collection("Recepients")
        .add(donor.toJason())
        .then((value) => Get.snackbar(
              "Success",
              "You are registered as Recipients",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green,
            ))
        .catchError((error) {
      Get.snackbar("Failed", "Failed to Register you as Recipients",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.redAccent);
    });
  }
}
