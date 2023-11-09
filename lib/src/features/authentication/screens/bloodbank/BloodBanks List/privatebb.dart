// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healthjunction/src/features/authentication/screens/clinicmodulescreens/clinicscreen2.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class PrivateBB extends StatefulWidget {
  const PrivateBB({super.key});

  @override
  State<PrivateBB> createState() => _PrivateBBState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
void _handleMenuPressed() {
  scaffoldKey.currentState?.openDrawer();
}

class _PrivateBBState extends State<PrivateBB> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: ReusableDrawerSideBar(
              color: Colors.red,
              headerText: "Blood Banks",
            ),
            key: scaffoldKey,
            appBar: Navbar(
                color: Colors.red,
                textNav: "Blood Banks",
                onMenuPressed: _handleMenuPressed)));
  }
}
