import 'package:flutter/material.dart';

class HeartRateCalculator extends StatefulWidget {
  HeartRateCalculator({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<HeartRateCalculator> createState() => _HeartRateCalculatorState();
}

class _HeartRateCalculatorState extends State<HeartRateCalculator> {
  var ageController = TextEditingController();
  var heartRateController = TextEditingController();
  var result = "";
  var bgColor = Colors.black;
  var borderColor = Colors.white;
  var gender = 'male'; // Default gender

  bool _showHRInfo = false;

  void _toggleHRInfo() {
    setState(() {
      _showHRInfo = !_showHRInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(150, 0, 0, 0),
        title: const Text(
          "Heart Rate (HR) Calculator",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info, color: Colors.white),
            onPressed: _toggleHRInfo,
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
                    'Heart Rate (HR) Calculator',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 21),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            gender = 'male';
                          });
                        },
                        icon: Icon(Icons.male, color: gender == 'male' ? Colors.blue : Colors.white, size: 130),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            gender = 'female';
                          });
                        },
                        icon: Icon(Icons.female, color: gender == 'female' ? Colors.pink : Colors.white, size: 130),
                      ),
                    ],
                  ),
                  const SizedBox(height: 21),
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
                  const SizedBox(height: 11),
                  TextField(
                    controller: heartRateController,
                    decoration: InputDecoration(
                      labelText: "Enter Your Heart Rate",
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.favorite, color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      var age = int.tryParse(ageController.text) ?? 0;
                      var heartRate = int.tryParse(heartRateController.text) ?? 0;

                      if (age != 0 && heartRate != 0) {
                        var rateCategory = calculateHeartRateCategory(age, heartRate, gender);
                        setState(() {
                          if (rateCategory == "High") {
                            bgColor = Colors.red;
                            borderColor = Colors.red;
                          } else if (rateCategory == "Low") {
                            bgColor = Colors.blue;
                            borderColor = Colors.blue;
                          } else {
                            bgColor = Colors.green;
                            borderColor = Colors.green;
                          }
                          result = "Your Heart Rate Category: $rateCategory";
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
                  if (_showHRInfo)
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Heart Rate (HR) Categories:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Normal: 60-100 beats per minute (bpm)',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'High: Above 100 bpm',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Low: Below 60 bpm',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Note: The result indicates the category of heart rate based on the entered values.',
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

  // Calculate Heart Rate Category
  String calculateHeartRateCategory(int age, int heartRate, String gender) {
    if (gender == 'male') {
      if (heartRate > 100) {
        return "High";
      } else if (heartRate < 60) {
        return "Low";
      } else {
        return "Normal";
      }
    } else {
      if (heartRate > 100) {
        return "High";
      } else if (heartRate < 60) {
        return "Low";
      } else {
        return "Normal";
      }
    }
  }
}
