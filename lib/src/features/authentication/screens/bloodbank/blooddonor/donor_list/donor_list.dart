// ignore_for_file: prefer_const_constructors, avoid_print, unused_element, unused_import, use_key_in_widget_constructors, unused_local_variable, deprecated_member_use, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/features/authentication/screens/clinicmodulescreens/clinicscreen2.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';
import 'package:url_launcher/url_launcher.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
void _handleMenuPressed() {
  scaffoldKey.currentState?.openDrawer();
}

class DonorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: Navbar(
          color: Colors.red,
          textNav: "Donor List",
          onMenuPressed: _handleMenuPressed),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Donor Registration'),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            // Add more items here
          ],
        ),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: fetchDonorData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(child: Text('No donor data available.'));
          } else if (snapshot.hasData) {
            List<DocumentSnapshot> donors = snapshot.data!;
            SizedBox(
              height: 20,
            );
            return ListView.separated(
              itemCount: donors.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (context, index) {
                var donor = donors[index].data() as Map<String, dynamic>;
                String fullName = donor['FullName'] ?? 'No Name';
                String email = donor['Email'] ?? 'No Email';
                String bloodType = donor['BloodType'] ?? 'No Blood Type';
                String phoneNumber = donor['Phone'] ?? 'No Phone Number';
                String city = donor['City'] ?? 'No City Added';
                String province = donor['Province'] ?? 'No Province Added';
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
                    'Email: $email\nBlood Type: $bloodType\nPhone Number: $phoneNumber\nCity: $city\nProvince:$province',
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
          } else {
            return Center(child: Text('Unknown error occurred.'));
          }
        },
      ),
    );
  }

  Future<List<DocumentSnapshot>> fetchDonorData() async {
    List<DocumentSnapshot> donors = [];
    try {
      QuerySnapshot<Map<String, dynamic>> donorData =
          await FirebaseFirestore.instance.collection('Donors').get();
      donors = donorData.docs;
    } catch (error) {
      // Handle errors here
      print('Error fetching donor data: $error');
    }
    return donors;
  }
}
