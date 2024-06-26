// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_typing_uninitialized_variables, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/clinicmodulescreens/clinicscreen1.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/Govtlabs.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/labsmainscreen.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/profile_page/profile_main_page.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class Laboratoriesmain extends StatelessWidget {
  var height, width;

  // List of images and titles
  
  List imgData = [ppLab, ppLab];
  List titles = ["Public Labs", "Private Labs"];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: ReusableDrawerSideBar(
        headerText: "Laboratories",
        color: clab, // Improved Color Combination
      ),
      body: SingleChildScrollView(
        child: Container(
          color: clab, // Improved Color Combination
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
        color: clab,
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
                      color: const Color.fromARGB(255, 90, 90, 90),
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
                    color: const Color.fromARGB(255, 90, 90, 90),
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
                  "Laboratories",
                  style: TextStyle(
                    fontSize: 35,
                    color: const Color.fromARGB(255, 90, 90, 90),
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
                    color: const Color.fromARGB(255, 90, 90, 90),
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
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: clab2,
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
          tag: 'bloodBankHero$index',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                imgData[index],
                width: 170,
              ),
              Text(
                titles[index],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(
                      255, 90, 90, 90), // Improved Color Combination
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
        Get.to(() => GovtLabsMainScreen());
        break;
      case 1:
        Get.to(() => LabsMainScreen());
        break;
    }
  }
}
