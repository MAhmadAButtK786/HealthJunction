// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, library_private_types_in_public_api, unused_import, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/clinicmodulescreens/clinicscreen2.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';
import 'package:url_launcher/url_launcher.dart';

class PublicBB extends StatefulWidget {
  PublicBB({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _PublicBBState createState() => _PublicBBState();
}

class _PublicBBState extends State<PublicBB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late TextEditingController _searchController;
  late String searchTerm = ''; // Declare searchTerm here

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 7),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _searchController = TextEditingController();
  }

  void _handleMenuPressed() {
    widget.scaffoldKey.currentState?.openDrawer();
  }

  void _performSearch() {
    setState(() {
      searchTerm = _searchController.text.toLowerCase().trim();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cBBPP,
        key: widget.scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Blood Banks",
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _performSearch();
              },
            ),
          ],
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white, fontSize: 17),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: FadeTransition(
                opacity: _animation,
                child: Image(image: AssetImage(ppb)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Public Blood Banks")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  if (snapshot.hasData) {
                    final publicbb = snapshot.data?.docs;
                    List<Widget> BBPWidget = [];
                    for (var pbb in publicbb!) {
                      final data = pbb.data() as Map<String, dynamic>;
                      if (data.containsKey("Name") &&
                          data.containsKey("License Number") &&
                          data.containsKey("Secter") &&
                          data.containsKey("Address")) {
                        if (searchTerm.isEmpty ||
                            data['Name'].toLowerCase().contains(searchTerm)) {
                          final publicbbinfo = Card(
                            color: Colors.white,
                            child: ExpansionTile(
                              title: Text(
                                "${data['Name']} ",
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              children: [
                                ListTile(
                                  title: Text(
                                    "License Number:${data['License Number']}\nSector:${data['Secter']}",
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.location_on),
                                  title: Text("Location: ${data['Address']}"),
                                  onTap: () {
                                    // ignore: deprecated_member_use
                                    launch(
                                        "https://www.google.com/maps/search/?api=1&query=${data['Address']}");
                                  },
                                ),
                              ],
                            ),
                          );
                          BBPWidget.add(publicbbinfo);
                        }
                      }
                    }
                    return ListView(
                      children: BBPWidget,
                    );
                  } else {
                    return Text('No data found');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
