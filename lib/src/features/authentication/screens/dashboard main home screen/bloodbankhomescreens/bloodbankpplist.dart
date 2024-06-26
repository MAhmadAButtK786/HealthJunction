// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables, unnecessary_import, unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/bloodbank/BloodBanks%20List/privatebb.dart';
import 'package:healthjunction/src/features/authentication/screens/bloodbank/BloodBanks%20List/publicbb.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/profile_page/profile_main_page.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar2.dart';

class BloodBankListPP extends StatelessWidget {
  BloodBankListPP({super.key});
  var height, width;

  // List of images and titles
  List imgData = [bbppl, bbppl];
  List titles = [" Private Blood Banks", "Public Blood Banks"];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: ReusableDrawerSideBar2(
        headerText: "Blood Bank",
        color: Colors.red, // Improved Color Combination
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.orange], // Adjust gradient colors
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ), // Improved Color Combination
          child: Column(
            children: [
              // Improved Header Design
              buildHeader(context),
              // GridView for Blood Bank options
              buildBloodBankGrid(),
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
          colors: [Colors.red, Colors.orange], // Adjust gradient colors
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
                  "Blood Bank ",
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

  // Method to build the Blood Bank Grid
  Widget buildBloodBankGrid() {
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
          tag: 'bloodBankHero$index',
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
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent, // Improved Color Combination
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
        Get.to(() => PrivateBB());
        break;
      case 1:
        Get.to(() => PublicBB());
        break;
    }
  }
}
