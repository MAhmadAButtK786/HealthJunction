// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IDCLab extends StatefulWidget {
  const IDCLab({super.key});

  @override
  State<IDCLab> createState() => _IDCLabState();
}

class _IDCLabState extends State<IDCLab> {
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
          FirebaseFirestore.instance.collection("IDC");
      final alliedLabLhr = await rootBundle.loadString(
          'assets/dataSets/2- islamabad diagnostic center (IDC).csv');
      List<List<dynamic>> csvdata = CsvToListConverter().convert(alliedLabLhr);
      List<List<dynamic>> data = csvdata;
      for (var i = 0; i < data.length; i++) {
        var record = {
          "Test Name": data[i][0],
          "Price": data[i][1],
        };
        await alliedlab.add(record);
      }
    } catch (e) {
      print("Error while adding Data $e");
    }
  }
}
