import 'package:flutter/material.dart';

class CaloriesCalculator extends StatefulWidget {
  CaloriesCalculator({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<CaloriesCalculator> createState() => _CaloriesCalculatorState();
}

class _CaloriesCalculatorState extends State<CaloriesCalculator> {
  var foodNameController = TextEditingController();
  var caloriesController = TextEditingController();
  var result = "";
  var totalCalories = 0;
  var bgColor = Colors.black;
  var borderColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(150, 0, 0, 0),
        title: const Text(
          "Calories Tracker",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        color: bgColor,
        child: Center(
          child: SizedBox(
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Calories Tracker',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 21),
                  TextField(
                    controller: foodNameController,
                    decoration: InputDecoration(
                      labelText: "Food Name",
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                  ),
                  const SizedBox(height: 11),
                  TextField(
                    controller: caloriesController,
                    decoration: InputDecoration(
                      labelText: "Calories",
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      var calories = int.tryParse(caloriesController.text) ?? 0;

                      if (calories != 0) {
                        setState(() {
                          totalCalories += calories;
                          result = "Total Calories: $totalCalories kcal";
                          borderColor = Colors.green; // Border color reflects result color
                          foodNameController.clear();
                          caloriesController.clear();
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter valid calories.'),
                          ),
                        );
                      }
                    },
                    child: const Text('Add Food'),
                  ),
                  const SizedBox(height: 11),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 19, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 45),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
