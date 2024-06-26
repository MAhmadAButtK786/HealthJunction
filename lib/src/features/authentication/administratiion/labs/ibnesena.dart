// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IBNeS extends StatefulWidget {
  const IBNeS({super.key});

  @override
  State<IBNeS> createState() => _IBNeSState();
}

class _IBNeSState extends State<IBNeS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        width: 280,
        child: ElevatedButton(
          onPressed: exportData,
          child: Text("Add IMLDC Lab Data in FireStore"),
        ),
      )),
    );
  }

  Future<void> exportData() async {
    try {
      final CollectionReference imlab =
          FirebaseFirestore.instance.collection("IMLDC");
      final imL = await rootBundle.loadString(
          'assets/dataSets/Lahore Medical Lab & Diagnostic Centre.csv');
      List<List<dynamic>> csvdata = CsvToListConverter().convert(imL);
      List<List<dynamic>> data = csvdata;
      for (var i = 1; i < data.length; i++) {
        var record = {
          "Test Name": data[i][1],
          "Price": data[i][2],
          "Sample Required": data[i][3],
          "Reporting Time": data[i][4],
          "Catagory": data[i][5],
        };
        await imlab.add(record);
      }
    } catch (e) {
      print("Error while adding Data $e");
    }
  }
}
