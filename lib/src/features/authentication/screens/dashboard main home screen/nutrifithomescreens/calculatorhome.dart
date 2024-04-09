import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/calculators/bmi.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class CalculatorMainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  CalculatorMainScreen({Key? key}) : super(key: key);

  final List<CalCardData> calCardData = [
    CalCardData(title: bmitxt, image: bmi, ),
    CalCardData(title: bmrtxt, image: bmr),
    CalCardData(title: dbtcal, image: diabetes),
    CalCardData(title: coles, image: cholestrolcal),
    CalCardData(title: kcal, image: calories),
    CalCardData(title: sleepcalcu, image: sleepcal),
    CalCardData(title: hrtc, image: thr),
    CalCardData(title: bpg, image: bpcal),
    CalCardData(title: wateri, image: waterintake),
    CalCardData(title: wd, image: weightlosscal),
    CalCardData(title: bt, image: tinycal),
    CalCardData(title: wi, image: weghtgain),
    CalCardData(title: pd, image: pddc),
    CalCardData(title: eb, image: exercisecalburn),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(166, 0, 0, 0), // Light brown
        key: scaffoldKey,
        drawer: ReusableDrawerSideBar(
          color: Colors.black, // Darker brown
          headerText: "Wellness Tools",
        ),
        appBar: Navbar(
          color: Colors.black, // Darker brown
          textNav: "Wellness Tools",
          onMenuPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 0.9, // Adjust aspect ratio for card size
            children: calCardData.map((data) => CalCard(data: data)).toList(),
          ),
        ),
      ),
    );
  }
}

class CalCardData {
  final String title;
  final String image;

  CalCardData({required this.title, required this.image});
}

class CalCard extends StatelessWidget {
  final CalCardData data;

  const CalCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
         Get.to(() => BMICalculator() );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content
            crossAxisAlignment: CrossAxisAlignment.center, // Center content
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(data.image),
                radius: 40.0, // Adjust avatar size
              ),
              const SizedBox(height: 8.0),
              Text(
                data.title,
                textAlign: TextAlign.center, // Center title text
                style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}



