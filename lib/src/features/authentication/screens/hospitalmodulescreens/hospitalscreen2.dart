// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class hospitalpage2 extends StatelessWidget {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(),
                height: height * 0.17,
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
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.sort,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage("images/women.png"),
                              ),
                            ),
                          ),
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
                          SizedBox(height: 5),
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
                height: height *
                    0.55, // controls the heirht of all scrollabla containers for holding pictures
                width: width,
                child: ListView(
                  scrollDirection:
                      Axis.horizontal, // Enable horizontal scrolling
                  children: [
                    // First horizontally scrollable container
                    Container(
                      width: width * 0.5, // Reduce width
                      height: height * 0.5, // Reduce height
                      margin:
                          EdgeInsets.all(10), // Add spacing between containers
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey, // Replace with your content
                      ),
                    ),
                    // Second horizontally scrollable container
                    Container(
                      width: width * 0.5, // Reduce width
                      height: height * 0.5, // Reduce height
                      margin:
                          EdgeInsets.all(10), // Add spacing between containers
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueGrey, // Replace with your content
                      ),
                    ),
                    // Third horizontally scrollable container
                    Container(
                      width: width * 0.5, // Reduce width
                      height: height * 0.5, // Reduce height
                      margin:
                          EdgeInsets.all(10), // Add spacing between containers
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey, // Replace with your content
                      ),
                    ),
                  ],
                ),
              ),
              // Text for hospital name
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Hospital Name",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Text for hospital address
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Hospital Address",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Adjust the value to control the roundness
                      ),
                      backgroundColor:
                          Colors.white, // Set the button's background color
                    ),
                    child: Text(
                      " More  ",
                      style:
                          TextStyle(color: Colors.black), // Set the text color
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Adjust the value to control the roundness
                      ),
                      backgroundColor:
                          Colors.white, // Set the button's background color
                    ),
                    child: Text(
                      " Maps  ",
                      style:
                          TextStyle(color: Colors.black), // Set the text color
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
