// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class Allied extends StatelessWidget {
  Allied({super.key});
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
        headerText: "Allied Lahore Lab",
      ),
      appBar: Navbar(
          color: clab,
          textNav: "Allied Lahore Lab",
          onMenuPressed: _handleMenuPressed),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Allied Lab')
                .orderBy("Code")
                .snapshots(),
            builder: (context, snapshot) {
              List<Widget> test = [];
              if (snapshot.hasData) {
                final ltest = snapshot.data?.docs;

                for (var document in ltest!) {
                  final data = document.data() as Map<String, dynamic>;
                  if (data.containsKey("Test Name") &&
                      data.containsKey("Code") &&
                      data.containsKey("Sample Required") &&
                      data.containsKey("Price") &&
                      data.containsKey("Reporting Time")) {
                    final charityinfo = Card(
                      color: cCharity,
                      child: ExpansionTile(
                        title: Text("${data['Test Name']}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                                "Code: ${data['Code']}\nPrice:${data['Price']}\nSample Required:${data['Sample Required']}\nReporting Time:${data['Reporting Time']}"),
                          ),
                        ],
                      ),
                    );

                    test.add(charityinfo);
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
    ));
  }
}
