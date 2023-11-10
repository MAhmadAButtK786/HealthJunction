// ignore_for_file: unused_import, library_private_types_in_public_api, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/features/authentication/screens/clinicmodulescreens/clinicscreen2.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class Govt extends StatefulWidget {
  const Govt({Key? key}) : super(key: key);

  @override
  _GovtState createState() => _GovtState();
}

class _GovtState extends State<Govt> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _searchController;
  late String searchTerm = ''; // Declare searchTerm here
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  void _performSearch() {
    setState(() {
      searchTerm = _searchController.text.toLowerCase().trim();
    });
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
        appBar: AppBar(
          title: Text("Government Based Lab"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _performSearch();
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                ),
              ),
            ),
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
                      if (searchTerm.isEmpty ||
                          data['District']
                              .toString()
                              .toLowerCase()
                              .contains(searchTerm) ||
                          data['Lab Name'].toLowerCase().contains(searchTerm)) {
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
