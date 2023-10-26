// ignore_for_file: file_names, use_key_in_widget_constructors, must_be_immutable, prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/clinicmodulescreens/clinicscreen2.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_screen/profile_screen.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class Medicine2 extends StatelessWidget {
  var height, width;

  // Mock data for the list
  List<String> mockData = [
    " Medicine suppliers 1  and there data, links ",
    " Medicine suppliers 2  and there data, links ",
    " Medicine suppliers 3  and there data, links ",
    " Medicine suppliers 4  and there data, links ",
    " Medicine suppliers 5  and there data, links ",
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer:
          ReusableDrawerSideBar(color: Colors.green, headerText: "Medicine"),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.green,
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
                          IconButton(
                            onPressed: () {
                              Get.to(() => ProfileScreen());
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
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            " Suppliers  ",
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
                              color: Colors.white54,
                              letterSpacing: 1,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Add a list of mock data in the white part
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: mockData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(mockData[index]),
                      // Add more styling or widgets as needed
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
