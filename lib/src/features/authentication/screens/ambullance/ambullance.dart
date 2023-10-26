// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, deprecated_member_use, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';
import 'package:url_launcher/url_launcher.dart';

class Ambulance extends StatelessWidget {
  Ambulance({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void _handleMenuPressed() {
    scaffoldKey.currentState?.openDrawer();
  }

  //Titles of Ambulance Provider
  List titles = [
    tEdhi,
    tCheepa,
    tRedCresent,
    tAlKhidmatFoundation,
    tRescu1122,
    tJDC
  ];
  //Contact Numbers of Ambulance Provider
  List helpLineNumbers = [
    nEdhi,
    nCheepa,
    nRedCresent,
    nAlKhidmatFoundation,
    nRescu1122,
    nJDC
  ];
  //Important Information About
  // Information about Ambulance Provider
  List organizationInfo = [
    infoEdhi,
    infoCheepa,
    infordc,
    infoalk,
    infoTR1122,
    infoJDC
  ];

  //Image List
  List imageList = [edhi, cheepa, redcs, alkhidmat, rescu1122, jdc];
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.only(left: 30, top: 45),
              width: 370,
              child: (Image(image: AssetImage(ambulance)))),
          Expanded(
            child: ListView.builder(
              itemCount: titles.length,
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
                        titles[index],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        helpLineNumbers[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      leading: SizedBox(child: Image.asset(imageList[index])),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.phone,
                            color: Colors.redAccent.shade400,
                          ),
                          onPressed: () async {
                            String phoneNumber = helpLineNumbers[index];
                            String url = 'tel:$phoneNumber';
                            try {
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            } catch (e) {
                              print('Error: $e');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text('Error: Could not make a phone call'),
                              ));
                            }
                          }),
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('About ${titles[index]}'),
                              content: Text(' ${organizationInfo[index]} .'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
