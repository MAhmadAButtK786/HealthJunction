import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExcelLab extends StatefulWidget {
  const ExcelLab({super.key});

  @override
  State<ExcelLab> createState() => _ExcelLabState();
}

class _ExcelLabState extends State<ExcelLab> {
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
      final CollectionReference excellab =
          FirebaseFirestore.instance.collection("excel");
      final excel =
          await rootBundle.loadString('assets/dataSets/1-excel labs.csv');
      List<List<dynamic>> csvdata = CsvToListConverter().convert(excel);
      List<List<dynamic>> data = csvdata;
      for (var i = 0; i < data.length; i++) {
        var record = {
          "Test Name": data[i][0],
          "Price": data[i][1],
        };
        await excellab.add(record);
      }
    } catch (e) {
      print("Error while adding Data $e");
    }
  }
}
