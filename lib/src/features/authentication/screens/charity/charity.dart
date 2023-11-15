// ignore_for_file: unnecessary_new, prefer_const_constructors, unused_import, no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';
import 'package:url_launcher/url_launcher.dart';

class CharityScreen extends StatelessWidget {
  CharityScreen({Key? key}) : super(key: key);

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
          color: Colors.deepPurple,
          headerText: "Charity",
        ),
        appBar: Navbar(
          color: Colors.deepPurple,
          textNav: "Charity",
          onMenuPressed: _handleMenuPressed,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(seconds: 2),
                builder: (BuildContext context, double _val, Widget? child) {
                  return Opacity(
                    opacity: _val,
                    child: Padding(
                      padding: EdgeInsets.only(top: _val * 20),
                      child: child,
                    ),
                  );
                },
                child: Image(
                  image: AssetImage(iCharity),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('NGOs').snapshots(),
              builder: (context, snapshot) {
                List<Widget> charityorg = [];
                if (snapshot.hasData) {
                  final charity = snapshot.data?.docs;

                  for (var document in charity!) {
                    final data = document.data() as Map<String, dynamic>;
                    if (data.containsKey("Title") &&
                        data.containsKey("Location") &&
                        data.containsKey("Account Details") &&
                        data.containsKey("Account Number") &&
                        data.containsKey("IBAN") &&
                        data.containsKey("Swift Code") &&
                        data.containsKey("Branch Code") &&
                        data.containsKey("Contact") &&
                        data.containsKey("Internation Contact") &&
                        data.containsKey("Descripyion")) {
                      final charityinfo = Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.deepPurple[100],
                        child: ExpansionTile(
                          title: Text(
                            "${data['Title']}",
                            style: TextStyle(
                              color: Colors.deepPurple[900],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.info_outline),
                              title: Text(
                                "Information: ${data['Descripyion']}",
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text("Contact: ${data['Contact']}"),
                              onTap: () {
                                launch("tel://${data['Contact']}");
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text(
                                  "Contact: ${data['Internation Contact']}"),
                              onTap: () {
                                launch("tel://${data['Internation Contact']}");
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.location_on),
                              title: Text("Location: ${data['Location']}"),
                              onTap: () {
                                launch(
                                    "https://www.google.com/maps/search/?api=1&query=${data['Location']}");
                              },
                            ),
                            ListTile(
                              leading: IconButton(
                                icon: Icon(Icons.copy),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: data['Account Number']));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Account number copied to clipboard')),
                                  );
                                },
                              ),
                              title: Text("${data['Account Details']}"),
                              subtitle: SelectableText(
                                "IBAN:${data['IBAN']}\nSwift Code:${data['Swift Code']}\nAccount Number:${data['Account Number']}\nBranch Code:${data['Branch Code']}",
                              ),
                            ),
                          ],
                        ),
                      );

                      charityorg.add(charityinfo);
                    }
                  }
                }
                return Expanded(
                  child: ListView(
                    children: charityorg,
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
