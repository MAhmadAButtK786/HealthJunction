// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/medicine%20suppliers%20module/Medicinesuppliersscreen.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/profile_page/profile_main_page.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/profile_screen/profile_screen.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class Medicinehome extends StatelessWidget {
  var height, width;

  List imgData = [medi2];
  List titles = [
    " Medicine Suppliers  ",
  ];
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: ReusableDrawerSideBar(
        color: Color.fromARGB(255, 67, 187, 161),
        headerText: "Medicine",
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.blue], // Adjust gradient colors
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green,
                      Colors.blue
                    ], // Adjust gradient colors
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
                                  )),
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
                            "Medicine  ",
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
                      crossAxisCount: 1,
                      childAspectRatio: 1.8,
                      mainAxisSpacing: 45,
                      crossAxisSpacing: 20),
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: titles.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => Medicine2());
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
                              width: 200,
                            ),
                            Text(
                              titles[index],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
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
    );
  }
}
