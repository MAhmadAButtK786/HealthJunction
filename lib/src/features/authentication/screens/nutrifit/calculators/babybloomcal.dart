// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:healthjunction/src/constants/image_string.dart';
class GrowthCalculator extends StatefulWidget {
  GrowthCalculator({Key? key}) : super(key: key);


  @override
  State<GrowthCalculator> createState() => _GrowthCalculatorState();
}

class _GrowthCalculatorState extends State<GrowthCalculator> {
  var ageController = TextEditingController();
  var wtController = TextEditingController();
  var htController = TextEditingController();
  var result = "";
  var borderColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 163, 255, 59),
        title: const Text(
          "BabyBloom Meter",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info, color: Colors.white),
            onPressed: () {
             launch("https://www.mychildgrowth.com");
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(sleepback),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Child Growth Calculator',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromRGBO(255, 235, 59, 1)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      labelText: "Age (years)",
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                    ),
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: wtController,
                    decoration: InputDecoration(
                      labelText: "Weight (kg)",
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                    ),
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: htController,
                    decoration: InputDecoration(
                      labelText: "Height (cm)",
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                    ),
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      var age = int.tryParse(ageController.text) ?? 0;
                      var weight = double.tryParse(wtController.text) ?? 0;
                      var height = double.tryParse(htController.text) ?? 0;

                      if (age > 0 && weight > 0 && height > 0) {
                        var percentile = calculatePercentile(age, weight, height);
                        setState(() {
                          result = "Your child's growth is in the $percentile percentile.";
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all the fields with valid values.'),
                          ),
                        );
                      }
                    },
                    child: const Text('Calculate Growth Percentile'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 18, color: Colors.purple, fontWeight:FontWeight.bold, fontSize:23),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      launch("https://www.cdc.gov/growthcharts/who_charts.htm");
                    },
                    child: const Text(
                      "View CDC Growth Charts Reference",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:25),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Calculate Growth Percentile
  String calculatePercentile(int age, double weight, double height) {
    // For simplicity, let's assume some random calculations here
    var percentile = (age * weight * height / 100).toStringAsFixed(2);
    return percentile;
  }
}
