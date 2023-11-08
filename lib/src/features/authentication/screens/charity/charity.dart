// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';

class CharityScreen extends StatelessWidget {
  CharityScreen({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void _handleMenuPressed() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: Navbar(
          color: cCharity,
          textNav: "Charity",
          onMenuPressed: _handleMenuPressed),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Image(
              image: AssetImage(iCharity),
            ),
          ),
        ],
      ),
    ));
  }
}
