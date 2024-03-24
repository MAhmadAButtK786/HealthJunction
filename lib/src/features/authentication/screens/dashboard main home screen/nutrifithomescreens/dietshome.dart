import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class DietMainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  DietMainScreen({Key? key}) : super(key: key);

  final List<DietCardData> dietCardData = [
    DietCardData(title: keto, image: ketoi),
    DietCardData(title: paleo, image: peleoi),
    DietCardData(title: whole30, image: whole30i),
    DietCardData(title: intermittentFasting, image: intermittenti),
    DietCardData(title: mediterranean, image: meditarriani),
    DietCardData(title: vegan, image: vegani),
    DietCardData(title: vegetarian, image: vegetariani),
    DietCardData(title: dash, image: dashi),
    DietCardData(title: flexitarian, image: flexitariani),
    DietCardData(title: lowCarb, image: lowcarbi),
    DietCardData(title: atkins, image: atkinsi),
    DietCardData(title: weightWatchers, image: wwi),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 221, 188, 170), // Light brown
        key: scaffoldKey,
        drawer: ReusableDrawerSideBar(
          color: const Color.fromARGB(255, 209, 169, 142), // Darker brown
          headerText: "Diets",
        ),
        appBar: Navbar(
          color: const Color.fromARGB(255, 209, 169, 142), // Darker brown
          textNav: "Diets",
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
            children: dietCardData.map((data) => DietCard(data: data)).toList(),
          ),
        ),
      ),
    );
  }
}

class DietCardData {
  final String title;
  final String image;

  DietCardData({required this.title, required this.image});
}

class DietCard extends StatelessWidget {
  final DietCardData data;

  DietCard({required this.data});

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
          // Navigate or perform action
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
