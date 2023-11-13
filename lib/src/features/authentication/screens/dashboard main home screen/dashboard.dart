// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, unused_import, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:healthjunction/main.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/charity/charity.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/bloodbankhomescreens/BloodBankHome.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/clinichomescreens/clinicmain.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/clinichomescreens/clinicuser.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/hospitalhomeScreens/HospitalUserHome.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/MedicineHome.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/hospitalhomeScreens/hospitalmain.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/labsmainscreen.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/profile_page/profile_main_page.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/profile_screen/profile_screen.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class Dashboard extends StatefulWidget {
  @override
  _AnihomebothState createState() => _AnihomebothState();
}

class _AnihomebothState extends State<Dashboard> with TickerProviderStateMixin {
  late AnimationController _healthJunctionController;
  late Animation<double> _healthJunctionOpacityAnimation;

  late AnimationController _innovativeAppController;
  late Animation<double> _innovativeAppOpacityAnimation;

  @override
  void initState() {
    super.initState();

    // Health Junction Animation
    _healthJunctionController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _healthJunctionOpacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_healthJunctionController);
    _healthJunctionController.forward();

    // Innovative App Animation
    _innovativeAppController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 13),
    );
    _innovativeAppOpacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_innovativeAppController);
    _innovativeAppController.forward();
  }

  @override
  void dispose() {
    _healthJunctionController.dispose();
    _innovativeAppController.dispose();
    super.dispose();
  }

  var height, width;

  List imgData = [clinicc, hosp, frontB, med, cc, l1];
  List titles = [
    "Clinic",
    "Hospital",
    "Blood Bank",
    "Medicine",
    "Charity",
    "Laboratories",
  ];
  List<Color> textColors = [
    Colors.teal, // Text color for Clinic
    Colors.blue, // Text color for Hospital
    Colors.red, // Text color for Blood Bank
    Colors.green, // Text color for Medicine
    Colors.purple, // Text color for Charity
    Color.fromARGB(255, 61, 189, 224), // Text color for Laboratories
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: ReusableDrawerSideBar(
          headerText: 'Health Junction',
          color: Colors.indigo,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.indigo,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(),
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
                            FadeTransition(
                              opacity: _healthJunctionOpacityAnimation,
                              child: Text(
                                " Health Junction",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            FadeTransition(
                              opacity: _innovativeAppOpacityAnimation,
                              child: Text(
                                " Innovative App for Health Care",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white54,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
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
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 45,
                        crossAxisSpacing: 20),
                    shrinkWrap: true,
                    //physics: NeverScrollableScrollPhysics(),
                    physics: ScrollPhysics(),

                    itemCount: imgData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (index == 0) {
                            Get.to(() => Clinicmain());
                          } else if (index == 1) {
                            Get.to(() => Hospitalhomemain());
                          } else if (index == 2) {
                            Get.to(() => BloodBankhome());
                          } else if (index == 3) {
                            Get.to(() => Medicinehome());
                          } else if (index == 4) {
                            Get.to(() => CharityScreen());
                          } else if (index == 5) {
                            Get.to(() => LabsMainScreen());
                          }
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                imgData[index],
                                width: 130,
                              ),
                              Text(titles[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: textColors[index],
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}
