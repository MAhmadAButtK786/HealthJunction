// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable, unused_import

import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class LabsMainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  LabsMainScreen({super.key});
  List title = [
    "Allied Lahore Lab",
    "Chughtai Lab",
    "Indus Lab",
    "Health Zone Lab",
    "Alnoor Diagnostic Center",
    "Islamabad Diagnostic Center",
    "Lahore Medical Lab and Diagnostic Center"
  ];
  List image = [alliedL, chugtai, induslab, healthZone, alnoor, idc, lmldc];
  void _handleMenuPressed() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: clab,
            key: scaffoldKey,
            drawer: ReusableDrawerSideBar(
              color: clab,
              headerText: "Laboratories",
            ),
            appBar: Navbar(
                color: clab,
                textNav: "Laboratories",
                onMenuPressed: _handleMenuPressed),
            body: Container(
              padding: EdgeInsets.only(),
              child: Image(image: AssetImage(labms)),
            )));
  }
}
