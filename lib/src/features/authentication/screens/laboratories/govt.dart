// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/features/authentication/screens/clinicmodulescreens/clinicscreen2.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class Govt extends StatefulWidget {
  Govt({Key? key}) : super(key: key);

  @override
  _GovtState createState() => _GovtState();
}

class _GovtState extends State<Govt> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void _handleMenuPressed() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: ReusableDrawerSideBar(
          color: clab,
          headerText: "Government Based Labs",
        ),
        appBar: Navbar(
          color: clab,
          textNav: "Government Based Labs",
          onMenuPressed: _handleMenuPressed,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Govt Registered Labs')
                  .orderBy("Serial Number")
                  .snapshots(),
              builder: (context, snapshot) {
                List<Widget> test = [];
                if (snapshot.hasError) {
                  print("Something Went Wrong ${snapshot.error}");
                }
                if (snapshot.hasData) {
                  final ltest = snapshot.data?.docs;

                  for (var document in ltest!) {
                    final data = document.data() as Map<String, dynamic>;
                    if (data.containsKey("Lab Name") &&
                        data.containsKey("District") &&
                        data.containsKey("Location") &&
                        data.containsKey("Serial Number")) {
                      final labinfo = Card(
                        color: cCharity,
                        child: ExpansionTile(
                          title: Text(
                            "${data['Lab Name']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                  "Serial Number:${data['Serial Number']}\nDistrict:${data['District']}\nLocation:${data['Location']}"),
                            ),
                          ],
                        ),
                      );

                      test.add(labinfo);
                    }
                  }
                }
                return Expanded(
                  child: ListView(
                    children: test,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
