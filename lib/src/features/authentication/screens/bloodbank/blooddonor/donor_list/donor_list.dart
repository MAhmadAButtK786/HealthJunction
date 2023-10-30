// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, use_build_context_synchronously, deprecated_member_use, duplicate_ignore, avoid_print
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MaterialApp(home: DonorList()));

class DonorList extends StatefulWidget {
  @override
  _DonorListState createState() => _DonorListState();
}

class _DonorListState extends State<DonorList> {
  String? selectedProvince;
  String? selectedBloodType;
  String? selectedCity; // New variable for selected city
  final cityController =
      TextEditingController(); // Controller for city TextField

  @override
  void initState() {
    super.initState();
    cityController.addListener(
        _updateCity); // Add listener to update city when text changes
  }

  @override
  void dispose() {
    cityController
        .dispose(); // Dispose controller when not needed to free up resources
    super.dispose();
  }

  void _updateCity() {
    setState(() {
      selectedCity = cityController
          .text; // Update selectedCity with current text in TextField
    });
  }

  Future<List<QueryDocumentSnapshot>> fetchRecipientData(
      String? selectedProvince,
      String? selectedBloodType,
      String? selectedCity) async {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection('Donors');

    if (selectedProvince != null && selectedProvince.isNotEmpty) {
      query = query.where('Province', isEqualTo: selectedProvince);
    }
    if (selectedBloodType != null && selectedBloodType.isNotEmpty) {
      query = query.where('BloodType', isEqualTo: selectedBloodType);
    }
    if (selectedCity != null && selectedCity.isNotEmpty) {
      query = query.where('City', isEqualTo: selectedCity);
    }

    QuerySnapshot<Map<String, dynamic>> recipientData = await query.get();
    return recipientData.docs;
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Filter Options'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DropdownButton<String>(
                    value: selectedProvince,
                    onChanged: (value) {
                      setState(() {
                        selectedProvince = value;
                      });
                      this.setState(() {}); // Add this line
                    },
                    hint: Text('Select Province'),
                    items: <String>[
                      'Punjab',
                      'Sindh',
                      'KPK',
                      'Blochistan',
                      'Islamabad',
                      'Gilgit Baltistan',
                      'AJK'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    value: selectedBloodType,
                    onChanged: (value) {
                      setState(() {
                        selectedBloodType = value;
                      });
                      this.setState(() {}); // Add this line
                    },
                    hint: Text('Select Blood Type'),
                    items: <String>[
                      'A-',
                      'B-',
                      'AB-',
                      'O-',
                      'A+',
                      'B+',
                      'AB+',
                      'O+',
                      'NI'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                      hintText: 'Enter City',
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel Filters'),
                  onPressed: () {
                    setState(() {
                      selectedProvince = null;
                      selectedBloodType = null;
                      cityController.clear();
                    });
                    this.setState(() {}); // Add this line
                  },
                ),
                TextButton(
                  child: Text('Apply Filters'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ReusableDrawerSideBar(
        color: Colors.red,
        headerText: "Donor List",
      ),
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: Text(
          "Donor List",
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list_alt),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
        centerTitle: true,
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: fetchRecipientData(
            selectedProvince, selectedBloodType, selectedCity),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No recipient data available.'));
          } else {
            List<QueryDocumentSnapshot> recipients = snapshot.data!;
            SizedBox(
              height: 10,
            );
            return ListView.builder(
              itemCount: recipients.length,
              itemBuilder: (context, index) {
                var recipient =
                    recipients[index].data() as Map<String, dynamic>;
                String fullName = recipient['FullName'] ?? 'No Name';
                String email = recipient['Email'] ?? 'No Email';
                String bloodType = recipient['BloodType'] ?? 'No Blood Type';
                double age = recipient['Age'] ?? 0.0;
                String phoneNumber = recipient['Phone'] ?? 'No Phone Number';
                String city = recipient['City'] ?? 'No City Added';
                String province = recipient['Province'] ?? 'No Province Added';
                return ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.red,
                  ),
                  title: Text(
                    fullName,
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  subtitle: Text(
                    'Email: $email\nBlood Type: $bloodType\nAge: $age\nPhone Number: $phoneNumber\nCity: $city\nProvince:$province',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  trailing: Icon(
                    Icons.phone,
                    color: Colors.red,
                  ),
                  onTap: () async {
                    String phone = phoneNumber;
                    String url = 'tel:$phone';
                    try {
                      // ignore: deprecated_member_use
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    } catch (e) {
                      print('Error: $e');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Error: Could not make a phone call'),
                      ));
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
