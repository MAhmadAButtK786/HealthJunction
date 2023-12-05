// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/clinicmodulescreens/apointmentStatus.dart';
import 'package:healthjunction/src/features/authentication/screens/clinicmodulescreens/clinicscreen1.dart';
import 'package:healthjunction/src/features/authentication/screens/hospitalmodulescreens/hospitalscreen1.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/profile_page/profile_main_page.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class Patientmain extends StatelessWidget {
  var height, width;

  List imgData = [bappoint, cappoint, hospital10];
  List titles = ["Book Appointment", "Check Appointments", "Hospitals"];
  List<Color> cardColors = [
    const Color(0xFFFDE9D9),
    Colors.white,
    Colors.white,
  ];
  List<Color> textColor = [
    Colors.blueGrey,
    Colors.lightBlueAccent,
    Colors.blue
  ];

  Patientmain({super.key});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: ReusableDrawerSideBar(
        headerText: "Patients",
        color: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 49, 125, 187),
                Color.fromARGB(255, 71, 235, 196),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            children: [
              buildHeader(context),
              buildClinicGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 49, 125, 187),
            Color.fromARGB(230, 71, 235, 197),
          ],
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
            padding: const EdgeInsets.only(
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
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(() => const ProfileMainPage());
                  },
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Patients",
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

  Widget buildClinicGrid() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      height: height * 0.75,
      width: width,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.8,
          mainAxisSpacing: 45,
          crossAxisSpacing: 20,
        ),
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return buildBloodBankItem(index);
        },
      ),
    );
  }

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
                      width: 140,
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
      case 0:
        Get.to(() => clinicpage1());
        break;
      case 1:
        Get.to(() => AppointmentStatusScreen());
        break;
      case 2:
        Get.to(() => hospitalpage1());
        break;
    }
  }
}
