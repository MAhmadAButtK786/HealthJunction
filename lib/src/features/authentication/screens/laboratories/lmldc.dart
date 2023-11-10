import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class LMLDC extends StatefulWidget {
  LMLDC({Key? key}) : super(key: key);

  @override
  _LMLDCState createState() => _LMLDCState();
}

class _LMLDCState extends State<LMLDC> {
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
          headerText: "Lahore Medical Lab & Diagnostic Center",
        ),
        appBar: Navbar(
          color: clab,
          textNav: "LMLDC",
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
                  .collection('IMLDC')
                  .orderBy("Catagory")
                  .snapshots(),
              builder: (context, snapshot) {
                List<Widget> test = [];
                if (snapshot.hasData) {
                  final ltest = snapshot.data?.docs;

                  for (var document in ltest!) {
                    final data = document.data() as Map<String, dynamic>;
                    if (data.containsKey("Test Name") &&
                        data.containsKey("Catagory") &&
                        data.containsKey("Sample Required") &&
                        data.containsKey("Price") &&
                        data.containsKey("Reporting Time")) {
                      final charityinfo = Card(
                        color: cCharity,
                        child: ExpansionTile(
                          title: Text(
                            "${data['Test Name']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                  "Catagory:${data['Catagory']}\nPrice:${data['Price']}\nSample Required:${data['Sample Required']}\nReporting Time:${data['Reporting Time']}"),
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
      ),
    );
  }
}
