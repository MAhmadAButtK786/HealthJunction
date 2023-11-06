// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BBPublicData extends StatefulWidget {
  const BBPublicData({super.key});

  @override
  State<BBPublicData> createState() => _BBPublicDataState();
}

class _BBPublicDataState extends State<BBPublicData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        width: 280,
        child: ElevatedButton(
          onPressed: exportData,
          child: Text("Add Public Blood Bank Data"),
        ),
      )),
    );
  }

  Future<void> exportData() async {
    try {
      final CollectionReference publicBB =
          FirebaseFirestore.instance.collection("Public Blood Banks");

      final bbPublicData =
          await rootBundle.loadString('assets/dataSets/blood banks public.csv');

      List<List<dynamic>> csvTable = CsvToListConverter().convert(bbPublicData);
      List<List<dynamic>> data = csvTable;
      for (var i = 1; i < data.length; i++) {
        var record = {
          'Name': data[i][1],
          'Address': data[i][2],
          'License Number': data[i][3],
          'Secter': data[i][4],
        };
        await publicBB.add(record);
        print("Data is Uploaded");
      }
    } catch (e) {
      print("Error While addind Data $e");
    }
  }
}
