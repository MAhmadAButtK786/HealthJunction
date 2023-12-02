// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class IDC extends StatefulWidget {
  IDC({Key? key}) : super(key: key);

  @override
  _IDCState createState() => _IDCState();
}

class _IDCState extends State<IDC> {
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
        appBar: AppBar(
          title: Text("IDC"),
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
                  .collection('IDCL')
                  .orderBy("Test Name")
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
                        data.containsKey("Price")) {
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
                                title: Text("Price:${data['Price']}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
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
