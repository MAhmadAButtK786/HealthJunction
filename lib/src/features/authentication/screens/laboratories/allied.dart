// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Allied extends StatefulWidget {
  Allied({Key? key}) : super(key: key);

  @override
  _AlliedState createState() => _AlliedState();
}

class _AlliedState extends State<Allied> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeInAnimation;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _searchController;
  late String searchTerm = ''; // Declare searchTerm here

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration:
          Duration(milliseconds: 500), // Set the duration of the animation
    );

    // Create a tween for fade-in animation
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation when the widget is built
    _animationController.forward();
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
          title: Text("Allied Lahore Lab"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _performSearch();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Allied Lab')
                  .orderBy("Code")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Add loading indicator while waiting for data
                }

                List<Widget> test = [];
                if (snapshot.hasData) {
                  final ltest = snapshot.data?.docs;

                  for (var i = 0; i < ltest!.length; i++) {
                    final document = ltest[i];
                    final data = document.data() as Map<String, dynamic>;
                    if (data.containsKey("Test Name") &&
                        data.containsKey("Code") &&
                        data.containsKey("Sample Required") &&
                        data.containsKey("Price") &&
                        data.containsKey("Reporting Time")) {
                      if (searchTerm.isEmpty ||
                          data['Test Name']
                              .toLowerCase()
                              .contains(searchTerm)) {
                        final charityinfo = FadeTransition(
                          opacity: _fadeInAnimation,
                          child: Card(
                            color: Colors.teal, // Update color as needed
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
                                      "Code: ${data['Code']}\nPrice:${data['Price']}\nSample Required:${data['Sample Required']}\nReporting Time:${data['Reporting Time']}"),
                                ),
                              ],
                            ),
                          ),
                        );

                        test.add(charityinfo);
                      }
                    }
                  }

                  // Reverse the list to show the latest items first
                  test = test.toList();
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
