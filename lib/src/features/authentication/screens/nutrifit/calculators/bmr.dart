import 'package:flutter/material.dart';


class BMRCalculator extends StatefulWidget {
  BMRCalculator({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<BMRCalculator> createState() => _BMRCalculatorState();
}

class _BMRCalculatorState extends State<BMRCalculator> {
  void _handleMenuPressed() {
    widget.scaffoldKey.currentState?.openDrawer();
  }

  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var ageController = TextEditingController();
  var result = "";
  var bgColor = Colors.black;
  var borderColor = Colors.white;
  var weightUnit = 'kg';
  var heightUnit = 'm';
  var gender = 'male';

  bool _showBMRInfo = false;

  void _toggleBMRInfo() {
    setState(() {
      _showBMRInfo = !_showBMRInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(150, 0, 0, 0),
        title: const Text(
          "BMR Calculator",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info, color: Colors.white),
            onPressed: _toggleBMRInfo,
          ),
        ],
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
                    'Basal Metabolic Rate',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            gender = 'male';
                          });
                        },
                        icon: Icon(Icons.male, color: gender == 'male' ? Colors.blue : Colors.white,size: 130,),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            gender = 'female';
                          });
                        },
                        icon: Icon(Icons.female, color: gender == 'female' ? Colors.pink : Colors.white, size: 130,),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'kg',
                        groupValue: weightUnit,
                        onChanged: (value) {
                          setState(() {
                            weightUnit = value.toString();
                          });
                        },
                      ),
                      const Text(
                        'kg',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Radio(
                        value: 'lb',
                        groupValue: weightUnit,
                        onChanged: (value) {
                          setState(() {
                            weightUnit = value.toString();
                          });
                        },
                      ),
                      const Text(
                        'lb',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  TextField(
                    controller: wtController,
                    decoration: InputDecoration(
                      labelText: "Enter Your Weight",
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.line_weight, color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'm',
                        groupValue: heightUnit,
                        onChanged: (value) {
                          setState(() {
                            heightUnit = value.toString();
                          });
                        },
                      ),
                      const Text(
                        'm',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Radio(
                        value: 'ft',
                        groupValue: heightUnit,
                        onChanged: (value) {
                          setState(() {
                            heightUnit = value.toString();
                          });
                        },
                      ),
                      const Text(
                        'ft',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  TextField(
                    controller: ftController,
                    decoration: InputDecoration(
                      labelText: "Enter Your Height",
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.height, color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 11),
                  TextField(
                    controller: inController,
                    decoration: InputDecoration(
                      labelText: "Enter Your Height (in Inches)",
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.height_sharp, color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 11),
                  TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      labelText: "Enter Your Age",
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.calendar_today, color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      var weight = double.tryParse(wtController.text) ?? 0;
                      var feet = double.tryParse(ftController.text) ?? 0;
                      var inches = double.tryParse(inController.text) ?? 0;
                      var age = int.tryParse(ageController.text) ?? 0;

                      double height;
                      if (heightUnit == 'ft') {
                        height = feet + (inches / 12);
                      } else {
                        height = feet * 0.3048; // Convert feet to meters
                      }

                      if (weight != 0 && height != 0 && age != 0) {
                        var bmr = calculateBMR(weight, height, age, weightUnit, heightUnit, gender);
                        setState(() {
                          result = "Your Basal Metabolic Rate (BMR) is ${bmr.toStringAsFixed(2)} calories/day.";
                          borderColor = Colors.green; // Border color reflects result color
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all the fields.'),
                          ),
                        );
                      }
                    },
                    child: const Text('Calculate'),
                  ),
                  const SizedBox(height: 11),
                  if (_showBMRInfo)
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Basal Metabolic Rate (BMR):',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'The Basal Metabolic Rate (BMR) is the amount of energy expended while at rest in a neutrally temperate environment, in the post-absorptive state (meaning that the digestive system is inactive, which requires about 12 hours of fasting in humans).',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'The BMR formula is as follows:',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'For men: BMR = 88.362 + (13.397 × weight in kg) + (4.799 × height in cm) - (5.677 × age in years)',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'For women: BMR = 447.593 + (9.247 × weight in kg) + (3.098 × height in cm) - (4.330 × age in years)',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Note: The result gives the number of calories needed per day to maintain current body weight at rest.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
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

  // Calculate BMR
  double calculateBMR(double weight, double height, int age, String weightUnit, String heightUnit, String gender) {
    double bmr;
    // Convert weight to kilograms if unit is 'lb'
    if (weightUnit == 'lb') {
      weight = weight * 0.453592; // 1 lb = 0.453592 kg
    }
    // Convert height to centimeters if unit is 'ft'
    if (heightUnit == 'ft') {
      height = height * 30.48; // 1 ft = 30.48 cm
    }

    // Calculate BMR using Harris-Benedict equation
    // For men
    if (gender == 'male') {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else {
      // For women
      bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }
    return bmr;
  }
}
