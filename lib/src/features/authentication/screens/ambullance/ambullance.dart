// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class Ambulance extends StatelessWidget {
  Ambulance({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void _handleMenuPressed() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: Navbar(
        color: Colors.redAccent,
        textNav: 'Ambullance',
        onMenuPressed: _handleMenuPressed,
      ),
      drawer: ReusableDrawerSideBar(
          color: Colors.redAccent, headerText: "Ambullance"),
    );
  }
}
