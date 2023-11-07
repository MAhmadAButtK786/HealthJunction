// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HealthZone extends StatefulWidget {
  const HealthZone({super.key});

  @override
  State<HealthZone> createState() => _HealthZoneState();
}

class _HealthZoneState extends State<HealthZone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        width: 280,
        child: ElevatedButton(
          onPressed: exportData,
          child: Text("Add Health Zone Lab Data in FireStore"),
        ),
      )),
    );
  }

  Future<void> exportData() async {
    try {
      final CollectionReference hzlab =
          FirebaseFirestore.instance.collection("Health Zone Lab");
      final healthzone =
          await rootBundle.loadString('assets/dataSets/Health zone labs.csv');
      List<List<dynamic>> csvdata = CsvToListConverter().convert(healthzone);
      List<List<dynamic>> data = csvdata;
      for (var i = 1; i < data.length; i++) {
        var record = {
          "Code": data[i][0],
          "Test Name": data[i][1],
          "Price": data[i][2],
          "Sample Required": data[i][3],
          "Reporting Time": data[i][4],
        };
        await hzlab.add(record);
      }
    } catch (e) {
      print("Error while adding Data $e");
    }
  }
}
