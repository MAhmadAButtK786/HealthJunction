// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class PublicBB extends StatefulWidget {
  const PublicBB({Key? key}) : super(key: key);

  @override
  _PublicBBState createState() => _PublicBBState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

void _handleMenuPressed() {
  scaffoldKey.currentState?.openDrawer();
}

class _PublicBBState extends State<PublicBB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
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
        drawer: ReusableDrawerSideBar(
          color: Colors.red,
          headerText: "Public Blood Banks",
        ),
        key: scaffoldKey,
        appBar: Navbar(
            color: Colors.red,
            textNav: "Public Blood Banks",
            onMenuPressed: _handleMenuPressed),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: FadeTransition(
                opacity: _animation,
                child: Image(image: AssetImage(ppb)),
              ),
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
                        final publicbbinfo = Card(
                          color: Colors.white,
                          child: ExpansionTile(
                            title: Text(
                              "${data['Name']} ",
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            children: [
                              ListTile(
                                  title: Text(
                                      "License Number:${data['License Number']}\nAddress:${data['Address']}\nSector:${data['Secter']}")),
                            ],
                          ),
                        );
                        BBPWidget.add(publicbbinfo);
                      }
                    }
                    return Expanded(
                      child: ListView(
                        children: BBPWidget,
                      ),
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
