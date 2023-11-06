// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlliedLab extends StatefulWidget {
  const AlliedLab({super.key});

  @override
  State<AlliedLab> createState() => _AlliedLabState();
}

class _AlliedLabState extends State<AlliedLab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        width: 280,
        child: ElevatedButton(
          onPressed: exportData,
          child: Text("Add Allied Lab Data in FireStore"),
        ),
      )),
    );
  }

  Future<void> exportData() async {
    try {
      final CollectionReference alliedlab =
          FirebaseFirestore.instance.collection("Allied Lab");
      final alliedLabLhr =
          await rootBundle.loadString('assets/dataSets/Allied Lahore Lab.csv');
      List<List<dynamic>> csvdata = CsvToListConverter().convert(alliedLabLhr);
      List<List<dynamic>> data = csvdata;
      for (var i = 0; i < data.length; i++) {
        var record = {
          "Code": data[i][0],
          "Test Name": data[i][1],
          "Price": data[i][2],
          "Sample Required": data[i][3],
        };
        await alliedlab.add(record);
      }
    } catch (e) {
      print("Error while adding Data $e");
    }
  }
}
