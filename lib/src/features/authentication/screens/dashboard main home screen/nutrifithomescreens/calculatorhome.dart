import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/calculators/babybloomcal.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/calculators/bmi.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/calculators/bmr.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/calculators/bp.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/calculators/calories.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/calculators/cholesterolcak.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/calculators/diabates.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/calculators/exercisecal.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/calculators/herat.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/calculators/pragnanc.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/calculators/sleep.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/calculators/water.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/calculators/weightgain.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/calculators/weightloss.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class CalculatorMainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  CalculatorMainScreen({Key? key}) : super(key: key);

  final List<CalCardData> calCardData = [
    CalCardData(title: bmitxt, image: bmi, screen: BMICalculator()),
    CalCardData(title: bmrtxt, image: bmr, screen: BMRCalculator()),
    CalCardData(title: dbtcal, image: diabetes, screen: DiabetesCalculator()),
    CalCardData(title: coles, image: cholestrolcal, screen: CholesterolCalculator()),
    CalCardData(title: kcal, image: calories, screen: CaloriesCalculator()),
    CalCardData(title: sleepcalcu, image: sleepcal, screen: SleepCalculator()),
    CalCardData(title: hrtc, image: thr, screen: HeartRateCalculator()),
    CalCardData(title: bpg, image: bpcal, screen: BloodPressureCalculator()),
    CalCardData(title: wateri, image: waterintake, screen: WaterIntakeCalculator()),
    CalCardData(title: wd, image: weightlosscal, screen: WeightLossCalculator()),
    CalCardData(title: bt, image: tinycal, screen: BabyBloomCal()),
    CalCardData(title: wi, image: weghtgain, screen: WeightGainCalculator()),
    CalCardData(title: pd, image: pddc, screen: PregnancyDueDateCalculator()),
    CalCardData(title: eb, image: exercisecalburn, screen: ExerciseCalorieBurnCalculator()),
    // Add other calculators here
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
  final Widget screen;

  CalCardData({required this.title, required this.image, required this.screen});
}

class CalCard extends StatelessWidget {
  final CalCardData data;

  const CalCard({Key? key, required this.data}) : super(key: key);

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
          Get.to( ()=> data.screen);
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
