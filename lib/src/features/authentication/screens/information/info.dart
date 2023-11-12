// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class Information extends StatefulWidget {
  const Information({Key? key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late TextEditingController _searchController;
  late String searchTerm = '';
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
    _searchController =
        TextEditingController(); // Initialize _searchController here
  }

  void _performSearch() {
    setState(() {
      searchTerm = _searchController.text.toLowerCase().trim();
    });
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
        drawer: ReusableDrawerSideBar(
          color: const Color.fromARGB(255, 112, 140, 163),
          headerText: "Health Junction",
        ),
        appBar: AppBar(
          title: Text(
            'Take A step For Your Health',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _performSearch();
              },
            ),
          ],
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 112, 140, 163),
        ),
        backgroundColor: Colors.blue,
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SlideTransition(
                position: _offsetAnimation,
                child: Text(
                  "Basic Health Information",
                  style: GoogleFonts.montserrat(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
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
                        if (searchTerm.isEmpty ||
                            data['Title'].toLowerCase().contains(searchTerm)) {
                          final informationWidget = Card(
                            color: Colors.white,
                            margin: EdgeInsets.all(8.0),
                            child: ExpansionTile(
                              title: Text(
                                data['Title'],
                                style: GoogleFonts.montserrat(
                                    color: Colors.blueAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              children: [
                                ListTile(
                                    title: Text(
                                  data['Description'],
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )),
                              ],
                            ),
                          );
                          infoWidgets.add(informationWidget);
                        }
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
