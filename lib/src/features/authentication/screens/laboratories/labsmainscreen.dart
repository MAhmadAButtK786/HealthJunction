// ignore_for_file: prefer_const_constructors, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
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
