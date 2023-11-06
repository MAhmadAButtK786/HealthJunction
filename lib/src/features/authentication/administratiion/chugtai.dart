// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChugtaiLabData extends StatefulWidget {
  const ChugtaiLabData({super.key});

  @override
  State<ChugtaiLabData> createState() => _ChugtaiLabDataState();
}

class _ChugtaiLabDataState extends State<ChugtaiLabData> {
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
