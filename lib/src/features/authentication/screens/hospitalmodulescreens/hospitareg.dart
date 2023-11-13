// ignore_for_file: prefer_const_constructors, sort_child_properties_last, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar2.dart';

class HospitalRegistration extends StatefulWidget {
  @override
  _HospitalRegistrationState createState() => _HospitalRegistrationState();
}

class _HospitalRegistrationState extends State<HospitalRegistration> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double _opacity = 1;

  void _handleMenuPressed() {
    scaffoldKey.currentState?.openDrawer();
  }

  void _animateOpacity() {
    setState(() {
      _opacity = _opacity == 1 ? 0.5 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: ReusableDrawerSideBar2(
        color: Theme.of(context).primaryColor,
        headerText: "Hospital Registration",
      ),
      appBar: Navbar(
        color: Theme.of(context).primaryColor,
        textNav: "Hospital Registration",
        onMenuPressed: _handleMenuPressed,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: _animateOpacity,
                  child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(seconds: 1),
                    child: Text(
                      'To register a hospital, we need the following information:',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                _buildDetailsTile(
                  context,
                  "Department Details we need",
                  "1. Number of Doctors in a Department\n"
                      "2. Doctor Education Level\n"
                      "3. Doctor Licence Number\n"
                      "4. Total Room in a Department\n"
                      "5. Doctor Schedule",
                ),
                _buildDetailsTile(
                  context,
                  "Ward Details we need",
                  "1. Number of Doctors in a Ward\n"
                      "2. Doctor Education Level\n"
                      "3. Doctor Licence Number\n"
                      "4. Total Beds in a Ward\n"
                      "5. Doctor Schedule\n"
                      "6. Number of Nursing Staff\n"
                      "7. Facilities in a Ward\n"
                      "8. Number of None Medical Staff in a Ward",
                ),
                _buildDetailsTile(
                  context,
                  "Doctors Details we need",
                  "1. Number of Doctors in a Hospital\n"
                      "2. Doctor Education Level\n"
                      "3. Doctor Licence Number\n"
                      "4. Doctor Schedule\n"
                      "5. Doctor Name\n"
                      "6. Doctor Age\n"
                      "7. Doctor Experience",
                ),
                SizedBox(height: 16.0), // Add some spacing
                _buildButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsTile(
      BuildContext context, String title, String subtitle) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'Go to the Website',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      ),
    );
  }
}
