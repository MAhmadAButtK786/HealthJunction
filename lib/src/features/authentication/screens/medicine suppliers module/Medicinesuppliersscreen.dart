// ignore_for_file: use_key_in_widget_constructors, unused_import, prefer_typing_uninitialized_variables, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, deprecated_member_use, unnecessary_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_screen/profile_screen.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';
import 'package:url_launcher/url_launcher.dart';

class Medicine2 extends StatelessWidget {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: ReusableDrawerSideBar(
          color: Colors.green, headerText: "Medical Suppliers"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
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
            // White part with hyperlinks
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  //_buildLink("Google", "https://www.google.com"),
                  _buildLink("DVAGO", "https://www.dvago.pk"),
                  _buildLink("dawaai", "https://dawaai.pk/"),
                  _buildLink(
                      "medicalstore.com.pk", "https://medicalstore.com.pk"),
                  _buildLink("Sehat.com.pk", "https://sehat.com.pk"),
                  _buildLink("Medoline", "https://medonline.pk/"),
                  _buildLink("Meri Pharmacy", "https://meripharmacy.pk"),
                  _buildLink("DWatson", "https://dwatson.pk"),
                  _buildLink("Ahmed Medico", "https://ahmedmedico.pk"),
                  //_buildLink("Facebook", "https://www.facebook.com"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLink(String text, String url) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 6),
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
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: Colors.green,
              //backgroundColor: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
