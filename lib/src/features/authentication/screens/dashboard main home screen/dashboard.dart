import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens/charity/charity.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/Healthpoints/healthpointshome.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/bloodbankhomescreens/BloodBankHome.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/MedicineHome.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/patient/patientdashboard.dart';
import 'package:healthjunction/src/features/authentication/screens/laboratories/laboratories.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/profile_page/profile_main_page.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
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
      duration: const Duration(seconds: 3),
    );
    _healthJunctionOpacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_healthJunctionController);
    _healthJunctionController.forward();

    // Innovative App Animation
    _innovativeAppController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 13),
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

  List imgData = [patient, hosp, frontB, events, nutriFit, med, cc, l1];
  List titles = [
    "Patient",
    "HealthPoints",
    "Blood Bank",
    "Events",
    "NutriMeter",
    "Medicine",
    "Charity",
    "Laboratories",
  ];
  List<Color> textColors = [
    Colors.teal, // Text color for Patient
    Colors.blue, // Text color for HealthZone
    Colors.red, // Text color for Blood Bank
    Colors.pinkAccent, // Text Colors For Events
    Colors.brown, //Text Color for NutriMeter
    Colors.green, // Text color for Medicine
    const Color.fromARGB(255, 185, 23, 214), // Text color for Charity
    const Color.fromARGB(255, 61, 189, 224), // Text color for Laboratories
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: ReusableDrawerSideBar(
          headerText: 'Health Junction',
          color: Colors.lightBlue,
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(back),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Container(
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
                                  color: Colors.blue,
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
                                color: Colors.blue,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeTransition(
                              opacity: _healthJunctionOpacityAnimation,
                              child: const Text(
                                " Health Junction",
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            FadeTransition(
                              opacity: _innovativeAppOpacityAnimation,
                              child: const Text(
                                " Innovative App for Health Care",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.blue,
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
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: AssetImage(back),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: height * 0.75,
                  width: width,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            mainAxisSpacing: 45,
                            crossAxisSpacing: 20),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: imgData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (index == 0) {
                            Get.to(() => Patientmain());
                          } else if (index == 1) {
                            Get.to(() => HealthPointsmain());
                          } else if (index == 2) {
                            Get.to(() => BloodBankhome());
                          } else if (index == 5) {
                            Get.to(() => Medicinehome());
                          } else if (index == 6) {
                            Get.to(() => CharityScreen());
                          } else if (index == 7) {
                            Get.to(() => Laboratoriesmain());
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: const [
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
                              Text(
                                titles[index],
                                style: TextStyle(
                                  fontSize: 20,
                                  
                                  fontWeight: FontWeight.bold,
                                  color: textColors[index],
                                ),
                              )
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
}
