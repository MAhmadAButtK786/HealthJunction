// ignore_for_file: prefer_const_constructors, unnecessary_import, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_screen/profile_screen.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class RecipientList extends StatefulWidget {
  const RecipientList({super.key});

  @override
  State<RecipientList> createState() => _RecipientListState();
}

class _RecipientListState extends State<RecipientList> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleMenuPressed() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: Navbar(
        color: Colors.red,
        textNav: "Recipient List",
        onMenuPressed: _handleMenuPressed,
      ),
      drawer:
          ReusableDrawerSideBar(color: Colors.red, headerText: "RecipientList"),
    );
  }
}
