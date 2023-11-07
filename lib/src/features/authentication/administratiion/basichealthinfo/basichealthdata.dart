// ignore_for_file: prefer_const_constructors, empty_catches, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasicHealthInfo extends StatefulWidget {
  const BasicHealthInfo({super.key});

  @override
  State<BasicHealthInfo> createState() => _BasicHealthInfoState();
}

class _BasicHealthInfoState extends State<BasicHealthInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 280,
          child: ElevatedButton(
              onPressed: exportData,
              child: Text("Add Basic Health Information")),
        ),
      ),
    );
  }

  Future<void> exportData() async {
    try {
      final CollectionReference basicHinfo =
          FirebaseFirestore.instance.collection("Basic Health Information");

      final basicinfo =
          await rootBundle.loadString('assets/dataSets/Basic health data.csv');

      List<List<dynamic>> csvData = CsvToListConverter().convert(basicinfo);
      List<List<dynamic>> data = csvData;
      for (var i = 0; i < data.length; i++) {
        var record = {
          "Title": data[i][0],
          "Description": data[i][1],
        };
        await basicHinfo.add(record);
        print("Data is loaded into the FireStore");
      }
    } catch (e) {
      print("Failed To load Data $e");
    }
  }
}
