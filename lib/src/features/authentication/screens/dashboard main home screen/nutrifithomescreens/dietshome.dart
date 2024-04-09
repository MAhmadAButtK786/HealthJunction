import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/nutrifit/diets/dietsdata.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

class DietMainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  DietMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 221, 188, 170),
        key: scaffoldKey,
        drawer: ReusableDrawerSideBar(
          color: const Color.fromARGB(255, 209, 169, 142),
          headerText: "Nutrition & Meal Plan",
        ),
        appBar: Navbar(
          color: const Color.fromARGB(255, 209, 169, 142),
          textNav: "Nutrition & Meal Plan",
          onMenuPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('diets').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final List<DietCardData> dietCardData = snapshot.data!.docs.map((DocumentSnapshot document) {
              return DietCardData(
                title: document['dietName'],
                image: document['imageUrl'],
                titleImageUrl: document['titleImageUrl'], // New field
                description: document['description'],
                additionalInfo: document['additionalInfo'],
                advantages: List<String>.from(document['advantages']),
                disadvantages: List<String>.from(document['disadvantages']),
                foodsToAvoid: List<String>.from(document['foodsToAvoid']),
                foodsToEat: List<String>.from(document['foodsToEat']),
              );
            }).toList();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 0.9,
                children: dietCardData.map((data) => DietCard(data: data)).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DietCard extends StatelessWidget {
  final DietCardData data;

  const DietCard({Key? key, required this.data}) : super(key: key);

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
         Get.to(() => DietDetailScreen(data: data),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage((data.titleImageUrl),),
                radius: 40.0,
              ),
           
              const SizedBox(height: 8.0),
              Text(
                data.title,
                textAlign: TextAlign.center,
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

class DietCardData {
  final String title;
  final String titleImageUrl; // New field for title image URL
  final String image;
  final String description;
  final String additionalInfo;
  final List<String> advantages;
  final List<String> disadvantages;
  final List<String> foodsToAvoid;
  final List<String> foodsToEat;

  DietCardData({
    required this.title,
    required this.titleImageUrl,
    required this.image,
    required this.description,
    required this.additionalInfo,
    required this.advantages,
    required this.disadvantages,
    required this.foodsToAvoid,
    required this.foodsToEat,
  });
}
