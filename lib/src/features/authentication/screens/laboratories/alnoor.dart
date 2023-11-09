// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class Alnoor extends StatelessWidget {
  Alnoor({super.key});
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
        headerText: "Alnoor Diagnostic Center",
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
                .collection('Alnoor Lab')
                .orderBy("Test Name")
                .snapshots(),
            builder: (context, snapshot) {
              List<Widget> test = [];
              if (snapshot.hasData) {
                final ltest = snapshot.data?.docs;

                for (var document in ltest!) {
                  final data = document.data() as Map<String, dynamic>;
                  if (data.containsKey("Test Name") &&
                      data.containsKey("Price")) {
                    final charityinfo = Card(
                      color: cCharity,
                      child: ExpansionTile(
                        title: Text("${data['Test Name']}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        children: <Widget>[
                          ListTile(
                            title: Text("Price:${data['Price']}"),
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
