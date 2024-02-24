// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PHCHospitals extends StatefulWidget {
  const PHCHospitals({super.key});

  @override
  State<PHCHospitals> createState() => _PHCHospitalsState();
}

class _PHCHospitalsState extends State<PHCHospitals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        width: 280,
        child: ElevatedButton(
          onPressed: exportData,
          child: Text("Add Hospitals Data in FireStore"),
        ),
      )),
    );
  }

  Future<void> exportData() async {
    try {
      final CollectionReference alliedlab =
          FirebaseFirestore.instance.collection("PHC Hospitals");
      final phcHospital =
          await rootBundle.loadString('assets/dataSets/PHC Hosp.csv');
      List<List<dynamic>> csvdata = CsvToListConverter().convert(phcHospital);
      List<List<dynamic>> data = csvdata;
      for (var i = 1; i < data.length; i++) {
        var record = {
          "District": data[i][1],
          "Hospital Name": data[i][2],
          "Address": data[i][3],
          "Sector": data[i][4],
          
        };
        await alliedlab.add(record);
      }
    } catch (e) {
      print("Error while adding Data $e");
    }
  }
}
