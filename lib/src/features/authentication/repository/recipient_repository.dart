// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/features/authentication/models/recipient_model.dart';

class RecipientRepository extends GetxController {
  static RecipientRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  Future<void> createUser(RecepientModel recepient) async {
    await _db
        .collection("Recepients")
        .add(recepient.toJason())
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
