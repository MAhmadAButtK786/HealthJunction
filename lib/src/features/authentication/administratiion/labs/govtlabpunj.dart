// ignore_for_file: prefer_const_constructors, avoid_print, unused_local_variable

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PunjabLabs extends StatefulWidget {
  const PunjabLabs({super.key});

  @override
  State<PunjabLabs> createState() => _PunjabLabsState();
}

class _PunjabLabsState extends State<PunjabLabs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        width: 280,
        child: ElevatedButton(
          onPressed: exportData,
          child: Text("Add Govt Registered Lab Data in FireStore"),
        ),
      )),
    );
  }

// ...

  Future<void> exportData() async {
    try {
      final CollectionReference alliedlab =
          FirebaseFirestore.instance.collection("Govt Registered Labs");

      final ByteData data1 =
          await rootBundle.load('assets/dataSets/Registered Labs.csv');
      final List<int> bytes = data1.buffer.asUint8List();
      final String csvContent = utf8.decode(bytes,
          allowMalformed: true); // Use ISO-8859-1 if necessary

      List<List<dynamic>> csvdata = CsvToListConverter().convert(csvContent);
      List<List<dynamic>> data = csvdata;
      for (var i = 1; i < data.length; i++) {
        var record = {
          "Serial Number": data[i][0],
          "District": data[i][1],
          "Lab Name": data[i][2],
          "Location": data[i][3],
        };
        await alliedlab.add(record);
      }
    } catch (e) {
      print("Error while adding Data $e");
    }
  }
}
