// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/govt.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class GovtLabsMainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static const titleN = ["Registered Labs in Punjab"];

  GovtLabsMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        drawer: ReusableDrawerSideBar(
          color: Colors.green,
          headerText: "Laboratories",
        ),
        appBar: Navbar(
          color: Colors.green,
          textNav: "Laboratories",
          onMenuPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Image.asset(govt),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: titleN.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Get.to(() => Govt());
                      }
                      print("Tapped on ${titleN[index]}");
                    },
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.easeIn,
                      margin: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.green,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          title: Text(
                            titleN[index],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: const Text(
                            'Click for more details',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
