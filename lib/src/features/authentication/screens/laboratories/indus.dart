// ignore_for_file: prefer_const_constructors, unused_import, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class Indus extends StatefulWidget {
  Indus({Key? key}) : super(key: key);

  @override
  _IndusState createState() => _IndusState();
}

class _IndusState extends State<Indus> {
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
        // drawer: ReusableDrawerSideBar(
        //   color: clab,
        //   headerText: "Indus Lab",
        // ),
        appBar: AppBar(
          title: Text("Indus Lab"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _performSearch();
              },
            ),
          ],
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    hintText: 'Search...', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Indus Lab')
                  .orderBy("Code")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Add loading indicator while waiting for data
                }
                List<Widget> test = [];
                if (snapshot.hasData) {
                  final ltest = snapshot.data?.docs;

                  for (var document in ltest!) {
                    final data = document.data() as Map<String, dynamic>;
                    if (data.containsKey("Test Name") &&
                        data.containsKey("Code") &&
                        data.containsKey("Sample Required") &&
                        data.containsKey("Reporting Time")) {
                      if (searchTerm.isEmpty ||
                          data['Test Name']
                              .toLowerCase()
                              .contains(searchTerm)) {
                        final charityinfo = Card(
                          color: Colors.teal,
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
                                    "Code: ${data['Code']}\nSample Required:${data['Sample Required']}\nReporting Time:${data['Reporting Time']}"),
                              ),
                            ],
                          ),
                        );

                        test.add(charityinfo);
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
