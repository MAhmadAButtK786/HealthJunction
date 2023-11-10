import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class HealthZoneL extends StatefulWidget {
  HealthZoneL({Key? key}) : super(key: key);

  @override
  _HealthZoneLState createState() => _HealthZoneLState();
}

class _HealthZoneLState extends State<HealthZoneL> {
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
          headerText: "Health Zone",
        ),
        appBar: AppBar(
          title: Text("Health Zone Lab"),
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
                  .collection('Health Zone Lab')
                  .orderBy("Code")
                  .snapshots(),
              builder: (context, snapshot) {
                List<Widget> test = [];
                if (snapshot.hasData) {
                  final ltest = snapshot.data?.docs;

                  for (var document in ltest!) {
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
                        final charityinfo = Card(
                          color: cCharity,
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
