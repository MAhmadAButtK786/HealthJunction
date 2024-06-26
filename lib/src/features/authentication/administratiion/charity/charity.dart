// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

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

// ...

  Future<void> exportData() async {
    try {
      final CollectionReference charityorgData =
          FirebaseFirestore.instance.collection('NGOs');

      final charityNGOsBytes = await rootBundle.load(
          'assets/dataSets/charity engos information new updaated (3).csv');
      final charityNGOs = utf8.decode(charityNGOsBytes.buffer.asUint8List(),
          allowMalformed: true);

      List<List<dynamic>> csvData = CsvToListConverter().convert(charityNGOs);

      for (var i = 1; i < csvData.length; i++) {
        var record = {
          "Title": csvData[i][0],
          // "Logo": logoUrl,
          "Descripyion": csvData[i][2],
          "Location": csvData[i][3],
          "Contact": csvData[i][4],
          "Internation Contact": csvData[i][5],
          "Account Details": csvData[i][6],
          "Account Number": csvData[i][7],
          "Branch Code": csvData[i][8],
          "IBAN": csvData[i][9],
          "Swift Code": csvData[i][10],
        };
        await charityorgData.add(record);
        print("Data Stored in Firestore Successfully ");
      }
    } on Exception catch (e) {
      print('Error during Storing Data: $e');
    }
  }
}
