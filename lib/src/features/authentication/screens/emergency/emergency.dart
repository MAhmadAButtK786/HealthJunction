// ignore_for_file: must_be_immutable, unused_label, prefer_const_constructors, use_build_context_synchronously, avoid_print, deprecated_member_use

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';

import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar2.dart';
import 'package:url_launcher/url_launcher.dart';

class Emergency extends StatelessWidget {
  Emergency({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void _handleMenuPressed() {
    scaffoldKey.currentState?.openDrawer();
  }

  List title = [
    tEdhiMCRoom,
    tCheepa,
    tAlKhidmatFoundation,
    tPolice,
    tJDC,
    tRedCresent,
    tRescu1122
  ];
  List contactNumbers = [
    nEdhiMCRoom,
    nCheepa,
    nAlKhidmatFoundation,
    nPolice,
    nJDC,
    nRedCresent,
    nRescu1122
  ];
  List imageOrg = [edhi, cheepa, alkhidmat, police, jdc, redcs, rescu1122];
  List organizationInfo = [
    infoEdhi,
    infoCheepa,
    infoalk,
    infoPolice,
    infoJDC,
    infordc,
    infoTR1122
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: Navbar(
          color: Colors.red,
          textNav: "Emergency",
          onMenuPressed: _handleMenuPressed),
      drawer:
          ReusableDrawerSideBar2(color: Colors.red, headerText: "Ambullance"),
      backgroundColor: cEmergency,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const Image(
              image: AssetImage(emergency),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: title.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      title[index],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 219, 12, 8)),
                    ),
                    subtitle: Text(
                      contactNumbers[index],
                      style:
                          TextStyle(fontSize: 16, color: Colors.red.shade600),
                    ),
                    leading: SizedBox(
                        child: Image(
                      image: AssetImage(imageOrg[index]),
                    )),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.red.shade400,
                      ),
                      onPressed: () async {
                        String phoneNumber = contactNumbers[index];
                        String url = 'tel:$phoneNumber';
                        try {
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        } catch (e) {
                          print('Error: $e');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Error: Could not make a phone call'),
                          ));
                        }
                      },
                    ),
                    onTap: () {
                      showDialog<Void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(title[index]),
                              content: Text(organizationInfo[index]),
                              actions: [
                                TextButton(
                                  child: Text("Colse"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    },
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
