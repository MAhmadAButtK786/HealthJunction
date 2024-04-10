import 'package:flutter/material.dart';
import 'package:healthjunction/src/constants/image_string.dart';

class WaterIntakeCalculator extends StatefulWidget {
  WaterIntakeCalculator({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<WaterIntakeCalculator> createState() => _WaterIntakeCalculatorState();
}

class _WaterIntakeCalculatorState extends State<WaterIntakeCalculator> {
  var weightController = TextEditingController();
  var activityLevel = 1;
  var climate = 1;
  var result = "";
  var borderColor = const Color.fromARGB(255, 5, 135, 241);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 135, 241),
        title: const Text(
          "HydroBalance",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Water Intake Information"),
                    content: const SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Why is water intake important?\n\n",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "1. Water regulates body temperature.\n\n"
                            "2. It helps in digestion and nutrient absorption.\n\n"
                            "3. Water flushes out toxins and waste products.\n\n"
                            "4. It supports the immune system and prevents infections.\n\n"
                            "5. Adequate hydration improves skin health and appearance.",
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Close"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(waterback),
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
                    'HydroBalance(Water Intake Calculator)',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 15, 120, 206)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: weightController,
                    decoration: InputDecoration(
                      labelText: "Weight (kg)",
                      labelStyle: const TextStyle(color: Color.fromARGB(255, 5, 135, 241)),
                      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                    ),
                    style: const TextStyle(color: Color.fromARGB(255, 5, 135, 241)),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    value: activityLevel,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text("Low activity")),
                      DropdownMenuItem(value: 2, child: Text("Moderate activity")),
                      DropdownMenuItem(value: 3, child: Text("High activity")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        activityLevel = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Activity Level",
                      labelStyle: const TextStyle(color: Color.fromARGB(255, 5, 135, 241)),
                      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                    ),
                    style: const TextStyle(color: Color.fromARGB(255, 5, 135, 241)),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    value: climate,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text("Normal climate")),
                      DropdownMenuItem(value: 2, child: Text("Hot climate")),
                      DropdownMenuItem(value: 3, child: Text("Cold climate")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        climate = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Climate",
                      labelStyle: const TextStyle(color: Color.fromARGB(255, 5, 135, 241)),
                      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                    ),
                    style: const TextStyle(color: Color.fromARGB(255, 5, 135, 241)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      var weight = double.tryParse(weightController.text) ?? 0;
                      if (weight > 0) {
                        var intake = calculateWaterIntake(weight, activityLevel, climate);
                        setState(() {
                          result = "Recommended water intake: $intake liters per day";
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a valid weight.'),
                          ),
                        );
                      }
                    },
                    child: const Text('Calculate Water Intake'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 5, 135, 241), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Calculate recommended water intake
  double calculateWaterIntake(double weight, int activityLevel, int climate) {
    double intake;
    switch (activityLevel) {
      case 1:
        intake = weight * 0.03; // Low activity
        break;
      case 2:
        intake = weight * 0.04; // Moderate activity
        break;
      case 3:
        intake = weight * 0.05; // High activity
        break;
      default:
        intake = weight * 0.03; // Default to low activity
    }
    // Adjust intake based on climate
    switch (climate) {
      case 2:
        intake += 0.5; // Hot climate
        break;
      case 3:
        intake -= 0.25; // Cold climate
        break;
      default:
        break;
    }
    return intake;
  }
}
