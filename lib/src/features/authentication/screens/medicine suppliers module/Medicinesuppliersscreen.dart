// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_import, must_be_immutable, prefer_typing_uninitialized_variables, file_names, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/profile_screen/profile_screen.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar2.dart';
import 'package:url_launcher/url_launcher.dart';

class Medicine2 extends StatelessWidget {
  var height, width;

  Medicine2({super.key});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: ReusableDrawerSideBar2(
        color: Colors.green,
        headerText: "Medical Suppliers",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopBar(context),
            _buildLinks(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green, Colors.blue], // Adjust gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      height: height * 0.28,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 35,
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(builder: (context) {
                  return InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 30,
                    ),
                  );
                }),
                _buildProfileIcon(context),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Medicine  ",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  "Suppliers  ",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Innovative App for Health Care",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProfileIcon(BuildContext context) {
    return Hero(
      tag: 'profile-tag',
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );
          },
          icon: Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildLinks() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildAnimatedLinkWithImage("DVAGO", "https://www.dvago.pk", dvago),
            _buildAnimatedLinkWithImage("Dawaai", "https://dawaai.pk/", dawaai),
            _buildAnimatedLinkWithImage(
                "Medical Store", "https://medicalstore.com.pk", medicalstore),
            _buildAnimatedLinkWithImage("Sehat", "https://sehat.com.pk", sehat),
            _buildAnimatedLinkWithImage(
                "Medoline", "https://medonline.pk/", medonline),
            _buildAnimatedLinkWithImage(
                "Meri Pharmacy", "https://meripharmacy.pk", maripharmacy),
            _buildAnimatedLinkWithImage(
                "Dwatson", "https://dwatson.pk", dwaston),
            _buildAnimatedLinkWithImage(
                "Ahmed Medico", "https://ahmedmedico.pk", ahmedmedico),
            _buildAnimatedLinkWithImage(
                "Servaid", "https://www.servaid.com.pk/", servaid),
            _buildAnimatedLinkWithImage(
                "HHL Pharmacy", "https://hlhpharmacy.com.pk/", hhl),
            _buildAnimatedLinkWithImage("Insta Care",
                "https://instacare.pk/online-pharmacy-in-pakistan", insta),
            _buildAnimatedLinkWithImage(
                "Next Health", "https://nexthealth.pk/", next),
            _buildAnimatedLinkWithImage(
                "E meds", "https://www.emeds.pk/", emed),
            _buildAnimatedLinkWithImage("Live Well Pharmacy",
                "https://www.livewellpharmacy.org/", livewell),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedLinkWithImage(
      String text, String url, String imagePath) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: 1,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () async {
            // Open the URL when tapped
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                // Image before the text
                Image.asset(
                  imagePath,
                  height: 50, // Adjust the height as needed
                  width: 50, // Adjust the width as needed
                ),
                SizedBox(width: 10), // Add some spacing between image and text
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
