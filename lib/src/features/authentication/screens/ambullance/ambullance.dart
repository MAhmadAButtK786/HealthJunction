// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_build_context_synchronously, avoid_print, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar2.dart';
import 'package:url_launcher/url_launcher.dart';

class Ambulance extends StatefulWidget {
  Ambulance({super.key});

  @override
  _AmbulanceState createState() => _AmbulanceState();
}

class _AmbulanceState extends State<Ambulance>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: Navbar(
        color: Colors.redAccent,
        textNav: 'Ambullance',
        onMenuPressed: _handleMenuPressed,
      ),
      drawer: ReusableDrawerSideBar2(
        color: Colors.redAccent,
        headerText: "Ambullance",
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              // Move the image right to left and left to right continuously
              return Transform.translate(
                offset: Offset(
                  MediaQuery.of(context).size.width *
                      (_controller.value -
                          1.0), // Adjusted for right to left movement
                  0,
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 90, top: 45),
                  width: 370,
                  child: Image(image: AssetImage(ambulance)),
                ),
              );
            },
          ),
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Error: Could not make a phone call'),
                              ),
                            );
                          }
                        },
                      ),
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
          ),
        ],
      ),
    );
  }
}
