// ignore_for_file: unused_import, library_prefixes, prefer_const_constructors, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class PrivateBBData extends StatefulWidget {
  const PrivateBBData({super.key});

  @override
  State<PrivateBBData> createState() => _PrivateBBDataState();
}

class _PrivateBBDataState extends State<PrivateBBData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 280,
          child: ElevatedButton(
            onPressed: exportData,
            child: Text("Add Private Blood Bank Data"),
          ),
        ),
      ),
    );
  }

  Future<void> exportData() async {
    try {
      final CollectionReference privatebb =
          FirebaseFirestore.instance.collection("Private Blood Banks");

      final bbPrivateData =
          await rootBundle.loadString("assets/dataSets/blood bank private.csv");
      List<List<dynamic>> csvTable =
          CsvToListConverter().convert(bbPrivateData);
      List<List<dynamic>> data = csvTable;

      for (var i = 1; i < data.length; i++) {
        var record = {
          'Name': data[i][1], // Assuming Name is at index 0 in your CSV data
          'Address': data[i]
              [2], // Assuming Address is at index 1 in your CSV data
          'License Number': data[i]
              [3], // Assuming License Number is at index 2 in your CSV data
          'Secter': data[i]
              [4], // Assuming Secter is at index 3 in your CSV data
        };
        await privatebb.add(record);
      }

      print('Data uploaded to Firestore');
    } catch (e) {
      print('Error uploading data: $e');
    }
  }
}
