// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar2.dart';

class AppointmentStatusScreen extends StatefulWidget {
  AppointmentStatusScreen({super.key});

  @override
  State<AppointmentStatusScreen> createState() =>
      _AppointmentStatusScreenState();
}

class Appointment {
  final String title;
  final String status;

  Appointment({required this.title, required this.status});
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
void _handleMenuPressed() {
  scaffoldKey.currentState?.openDrawer();
}

class _AppointmentStatusScreenState extends State<AppointmentStatusScreen> {
  List<Appointment> appointments = [
    Appointment(title: 'Appointment 1', status: 'Scheduled'),
    Appointment(title: 'Appointment 2', status: 'Completed'),
    Appointment(title: 'Appointment 3', status: 'Canceled'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ReusableDrawerSideBar2(
          color: Colors.tealAccent.shade400, headerText: "Appointment Screen"),
      key: scaffoldKey,
      appBar: Navbar(
          color: Colors.tealAccent.shade400,
          textNav: "Appointment Screen",
          onMenuPressed: _handleMenuPressed),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(appointments[index].title),
            subtitle: Text('Status: ${appointments[index].status}'),
            trailing: _buildStatusIcon(appointments[index].status),
          );
        },
      ),
    );
  }

  Widget _buildStatusIcon(String status) {
    IconData icon;
    Color color;

    switch (status.toLowerCase()) {
      case 'scheduled':
        icon = Icons.schedule;
        color = Colors.blue;
        break;
      case 'completed':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'canceled':
        icon = Icons.cancel;
        color = Colors.red;
        break;
      default:
        icon = Icons.error;
        color = Colors.grey;
    }

    return Icon(icon, color: color);
  }
}
