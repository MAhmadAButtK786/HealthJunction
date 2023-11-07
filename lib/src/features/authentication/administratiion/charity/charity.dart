// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CharityNGOData extends StatefulWidget {
  const CharityNGOData({super.key});

  @override
  State<CharityNGOData> createState() => _CharityNGODataState();
}

class _CharityNGODataState extends State<CharityNGOData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SizedBox(
          width: 280,
          child: ElevatedButton(
            onPressed: exportData,
            child: Text("Adding Charity Organization Data"),
          )),
    ));
  }

  Future<void> exportData() async {
    try {
      final CollectionReference charityorgData =
          FirebaseFirestore.instance.collection('charity NGOs Information');

      final charityNGOs =
          await rootBundle.loadString('charity engos information.csv');

      List<List<dynamic>> csvdata = CsvToListConverter().convert(charityNGOs);
      List<List<dynamic>> data = csvdata;
      for (var i = 0; i < data.length; i++) {
        var record = {
          "Title": data[i][0],
          "Basic Information": data[i][1],
          "Location": data[i][2],
          "Contact": data[i][3],
        };
        print("Data Stored in Frestore Successfully ");
      }
    } catch (e) {
      print("Error during Storig Data $e");
    }
  }
}
