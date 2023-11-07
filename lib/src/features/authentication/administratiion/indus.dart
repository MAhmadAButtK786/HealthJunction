// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IndusLab extends StatefulWidget {
  const IndusLab({super.key});

  @override
  State<IndusLab> createState() => _IndusLabState();
}

class _IndusLabState extends State<IndusLab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        width: 280,
        child: ElevatedButton(
          onPressed: exportData,
          child: Text("Add Indus Lab Data in FireStore"),
        ),
      )),
    );
  }

  Future<void> exportData() async {
    try {
      final CollectionReference induslab =
          FirebaseFirestore.instance.collection("Indus Lab");
      final indusLabLhr = await rootBundle
          .loadString('assets/dataSets/Indus Clinical Laboratories.csv');
      List<List<dynamic>> csvdata = CsvToListConverter().convert(indusLabLhr);
      List<List<dynamic>> data = csvdata;
      for (var i = 1; i < data.length; i++) {
        var record = {
          "Code": data[i][1],
          "Test Name": data[i][2],
          "Sample Required": data[i][3],
          "Reporting Time": data[i][4],
        };
        await induslab.add(record);
      }
    } catch (e) {
      print("Error while adding Data $e");
    }
  }
}
