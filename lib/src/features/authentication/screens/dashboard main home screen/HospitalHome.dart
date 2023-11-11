// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unnecessary_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/hospitalmodulescreens/hositalscreen3.dart';
import 'package:healthjunction/src/features/authentication/screens/hospitalmodulescreens/hospitalscreen1.dart';
import 'package:healthjunction/src/features/authentication/screens/hospitalmodulescreens/hospitalscreen2.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/profile_page/profile_main_page.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class Hospitalhome extends StatelessWidget {
  var height, width;

  // List of images and titles
  List imgData = [hospital, hospital];
  List titles = ["Check Availability / Information", "Appointment"];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: ReusableDrawerSideBar(
        color: Colors.blueAccent,
        headerText: "Hospitals",
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blueAccent,
          child: Column(
            children: [
              // Improved Header Design
              buildHeader(context),
              // GridView for Hospital options
              buildHospitalGrid(),
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
          colors: [
            Colors.blueAccent,
            Colors.lightBlueAccent
          ], // Adjust gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
                      size: 40,
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
                  "Hospitals",
                  style: TextStyle(
                    fontSize: 30,
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

  // Method to build the Hospital Grid
  Widget buildHospitalGrid() {
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
        physics: NeverScrollableScrollPhysics(),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return buildHospitalItem(index);
        },
      ),
    );
  }

  // Method to build a Hospital Item in the Grid
  Widget buildHospitalItem(int index) {
    return InkWell(
      onTap: () => handleGridItemClick(index),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 7,
              blurRadius: 9,
            ),
          ],
        ),
        // Apply Hero Animation for smooth image transition
        child: Hero(
          tag: 'hospitalHero$index',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                imgData[index],
                width: 100,
              ),
              Text(
                titles[index],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to handle grid item click
  void handleGridItemClick(int index) {
    switch (index) {
      case 0:
        Get.to(() => hospitalpage1());
        break;
      case 1:
        Get.to(() => hospitalpage3());
        break;
    }
  }
}
