// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healthjunction/src/features/authentication/screens/bloodbank/BloodBanks%20List/privatebb.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class PublicBB extends StatefulWidget {
  const PublicBB({super.key});

  @override
  State<PublicBB> createState() => _PublicBBState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
void _handleMenuPressed() {
  scaffoldKey.currentState?.openDrawer();
}

class _PublicBBState extends State<PublicBB> {
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
