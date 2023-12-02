// ignore_for_file: prefer_const_constructors, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/allied.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/alnoor.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/chughtai.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/excel.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/govt.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/healthzone.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/idc.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/indus.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/lmldc.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class LabsMainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  LabsMainScreen({super.key});
  List titleN = [
    "Registered Labs In Pakistan By Government",
    "Allied Lahore Lab",
    "Chughtai Lab",
    "Indus Lab",
    "Health Zone Lab",
    "Alnoor Diagnostic Center",
    "Islamabad Diagnostic Center",
    "Lahore Medical Lab and Diagnostic Center",
    "Excel",
  ];
  List image = [
    govt,
    alliedL,
    chugtai,
    induslab,
    healthZone,
    alnoor,
    idc,
    lmldc,
    excel,
  ];

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
          onMenuPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
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
                    margin: EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
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
                          if (index == 1) {
                            Get.to(() => Allied());
                          } else if (index == 2) {
                            Get.to(() => Chughtai());
                          } else if (index == 3) {
                            Get.to(() => Indus());
                          } else if (index == 4) {
                            Get.to(() => HealthZoneL());
                          } else if (index == 5) {
                            Get.to(() => Alnoor());
                          } else if (index == 6) {
                            Get.to(() => IDC());
                          } else if (index == 7) {
                            Get.to(() => LMLDC());
                          } else if (index == 8) {
                            Get.to(() => ExcelL());
                          } else if (index == 0) {
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
      ),
    );
  }
}
