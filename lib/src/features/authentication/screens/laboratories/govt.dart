// ignore_for_file: unused_import, library_private_types_in_public_api, prefer_const_constructors, avoid_print, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

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
        appBar: AppBar(
          title: Text("Registered Labs in Punjab"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _performSearch();
              },
            ),
          ],
          backgroundColor: Colors.green,
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
                  .collection('Punjab Register Lab')
                  .orderBy("Serial Number")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Add loading indicator while waiting for data
                }
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
                          color: Colors.green.shade500,
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
                                  "Serial Number:${data['Serial Number']}\nDistrict:${data['District']}",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.phone,
                                    color: Colors.white, size: 30),
                                title: Text(
                                  "Contact: ${data['Phone Number']}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  launch("tel://${data['Phone Number']}");
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.location_on,
                                    color: Colors.white, size: 30),
                                title: Text(
                                  "Location: ${data['Location']}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  launch(
                                      "https://www.google.com/maps/search/?api=1&query=${data['Location']}");
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: Icon(FontAwesomeIcons.whatsapp,
                                        color: Colors.white, size: 30),
                                    onPressed: () {
                                      launch("https://wa.me/${data['Phone Number']}");
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.call,
                                        color: Colors.white, size: 30),
                                    onPressed: () {
                                      launch("tel://${data['Phone Number']}");
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.message,
                                        color: Colors.white, size: 30),
                                    onPressed: () {
                                      launch("sms:${data['Phone Number']}");
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.map,
                                        color: Colors.white, size: 30),
                                    onPressed: () {
                                      launch(
                                          "https://www.google.com/maps/search/?api=1&query=${data['Location']}");
                                    },
                                  ),
                                ],
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
