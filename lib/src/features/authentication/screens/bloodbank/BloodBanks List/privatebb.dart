// ignore_for_file: unused_import, prefer_const_constructors, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/clinicmodulescreens/clinicscreen2.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class PrivateBB extends StatefulWidget {
  PrivateBB({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  State<PrivateBB> createState() => _PrivateBBState();
}

void _handleMenuPressed() {
  scaffoldKey.currentState?.openDrawer();
}

class _PrivateBBState extends State<PrivateBB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

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
          headerText: "Blood Banks",
        ),
        key: scaffoldKey,
        appBar: Navbar(
            color: Colors.red,
            textNav: "Blood Banks",
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
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Private Blood Banks")
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
                        SizedBox(
                          height: 28,
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
