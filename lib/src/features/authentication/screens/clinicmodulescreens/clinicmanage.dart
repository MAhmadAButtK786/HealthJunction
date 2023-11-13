// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar2.dart';

class ClinicManage extends StatefulWidget {
  const ClinicManage({Key? key}) : super(key: key);

  @override
  State<ClinicManage> createState() => _ClinicManageState();
}

class _ClinicManageState extends State<ClinicManage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleMenuPressed() {
    scaffoldKey.currentState?.openDrawer();
  }

  Future<void> _showDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: ReusableDrawerSideBar2(
          color: Colors.tealAccent.shade400,
          headerText: "Clinic Management",
        ),
        appBar: Navbar(
          color: Colors.tealAccent.shade400,
          textNav: "Clinic Management",
          onMenuPressed: _handleMenuPressed,
        ),
        body: ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(appointments[index].username),
                subtitle: Text(
                    'Appointment Date: ${appointments[index].date}\nTime: ${appointments[index].time}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.check_circle, color: Colors.green),
                      onPressed: () {
                        _showDialog('Appointment Accepted',
                            'You have accepted the appointment.');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.cancel, color: Colors.red),
                      onPressed: () {
                        _showDialog('Appointment Rejected',
                            'You have rejected the appointment.');
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Appointment {
  final String username;
  final String date;
  final String time;

  Appointment({required this.username, required this.date, required this.time});
}

List<Appointment> appointments = [
  Appointment(username: 'User1', date: '2023-11-15', time: '10:00 AM'),
  Appointment(username: 'User2', date: '2023-11-16', time: '2:00 PM'),
  // Add more appointments here
];
