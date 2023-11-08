// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Information extends StatefulWidget {
  const Information({Key? key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 1.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Basic Health Information"),
        //   centerTitle: true,
        //   backgroundColor: Colors.blueAccent,
        // ),

        backgroundColor: Colors.blue,

        body: Container(
          child: Column(
            children: [
              SlideTransition(
                position: _offsetAnimation,
                child: Text(
                  "Basic Health Information",
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Basic Health Information')
                    .snapshots(),
                builder: (context, snapshot) {
                  List<Widget> infoWidgets = [];
                  if (snapshot.hasData) {
                    final information = snapshot.data?.docs;
                    for (var document in information!) {
                      final data = document.data() as Map<String, dynamic>;
                      if (data.containsKey('Title') &&
                          data.containsKey('Description')) {
                        final informationWidget = Card(
                          color: Colors.white,
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              data['Title'],
                              style: GoogleFonts.montserrat(
                                  color: Colors.blueAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              data['Description'],
                              style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        );
                        infoWidgets.add(informationWidget);
                      }
                    }
                  }

                  return Expanded(
                    child: ListView(
                      children: infoWidgets,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
