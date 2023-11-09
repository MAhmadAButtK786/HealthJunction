// ignore_for_file: prefer_const_constructors, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/administratiion/labs/healthzone.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/allied.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/alnoor.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/chughtai.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/govt.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/idc.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/indus.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/lmldc.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class LabsMainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  LabsMainScreen({super.key});
  List titleN = [
    "Allied Lahore Lab",
    "Chughtai Lab",
    "Indus Lab",
    "Health Zone Lab",
    "Alnoor Diagnostic Center",
    "Islamabad Diagnostic Center",
    "Lahore Medical Lab and Diagnostic Center",
    "Registered Labs In Pakistan By Government",
  ];
  List image = [
    alliedL,
    chugtai,
    induslab,
    healthZone,
    alnoor,
    idc,
    lmldc,
    govt
  ];
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Image(image: AssetImage(labms)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: titleN.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8.0), // Add space around the Container
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(image[index]),
                        radius: 20,
                      ),
                      title: Text(
                        titleN[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      subtitle: Text(
                        'Click for more details',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () {
                        if (index == 0) {
                          Get.to(() => Allied());
                        }
                        if (index == 1) {
                          Get.to(() => Chughtai());
                        }
                        if (index == 2) {
                          Get.to(() => Indus());
                        }
                        if (index == 3) {
                          Get.to(() => HealthZone());
                        }
                        if (index == 4) {
                          Get.to(() => Alnoor());
                        }
                        if (index == 5) {
                          Get.to(() => IDC());
                        }
                        if (index == 6) {
                          Get.to(() => LMLDC());
                        }
                        if (index == 7) {
                          Get.to(() => Govt());
                        }
                        print("Tapped on ${titleN[index]}");
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
