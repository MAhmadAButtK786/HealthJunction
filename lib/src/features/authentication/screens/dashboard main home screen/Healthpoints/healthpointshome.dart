// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_typing_uninitialized_variables, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/clinicmodulescreens/clinicscreen1.dart';
import 'package:healthjunction/src/features/authentication/screens/hospitalmodulescreens/hospitalscreen1.dart';
import 'package:healthjunction/src/features/authentication/screens/hospitalmodulescreens/hospitareg.dart';
import 'package:healthjunction/src/features/authentication/screens/hospitalmodulescreens/phcregisteredhospitals.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/profile_page/profile_main_page.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class HealthPointsmain extends StatelessWidget {
  var height, width;

  // List of images and titles
  List imgData = [govt, hospitalmain ,hospital3];
  List titles = ["PHC Registered Hospitals","Hospitals","Hospitals Registration"];
  List<Color> cardColors = [
     Colors.white,
    Colors.white,
    Colors.white,
   
  ];
  List<Color> textColor = [
      Colors.green,
    Colors.blueAccent,
    Colors.blue,
    
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: ReusableDrawerSideBar(
        headerText: "Clinic",
        color: Colors.blue, // Improved Color Combination
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.tealAccent
              ], // Adjust gradient colors
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ), // Improved Color Combination
          child: Column(
            children: [
              // Improved Header Design
              buildHeader(context),
              // GridView for Clinic options
              buildClinicGrid(),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build the header
  Widget buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.tealAccent], // Adjust gradient colors
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
      ),
      height: height * 0.25,
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
                Builder(
                  builder: (context) => InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(() => ProfileMainPage());
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                )
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
                  "Health Points",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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

  // Method to build the Clinic Grid

  Widget buildClinicGrid() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      height: height * 0.75,
      width: width,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.8,
          mainAxisSpacing: 45,
          crossAxisSpacing: 20,
        ),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return buildBloodBankItem(index);
        },
      ),
    );
  }

  // Method to build a Blood Bank Item in the Grid
  Widget buildBloodBankItem(int index) {
   return InkWell(
      onTap: () => handleGridItemClick(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: cardColors[index], // Assigning specific color to the card
          boxShadow: [
            const BoxShadow(
              color: Colors.black26,
              spreadRadius: 7,
              blurRadius: 9,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: 'bloodBankHero$index',
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      imgData[index],
                      width: 150,
                    ),
                    Text(
                      titles[index],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor[index],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleGridItemClick(int index) {
    switch (index) {
      case 2:
        Get.to(() => HospitalRegistration());
        break;
     
      case 1:
        Get.to(() => const HospitalPage1());
        break;
      case 0:
      Get.to(() => const GovtHosp());
    }
  }
}
