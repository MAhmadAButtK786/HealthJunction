import 'package:flutter/material.dart';

class BloodPressureCalculator extends StatefulWidget {
  BloodPressureCalculator({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<BloodPressureCalculator> createState() => _BloodPressureCalculatorState();
}

class _BloodPressureCalculatorState extends State<BloodPressureCalculator> {
  void _handleMenuPressed() {
    widget.scaffoldKey.currentState?.openDrawer();
  }

  var systolicController = TextEditingController();
  var diastolicController = TextEditingController();
  var result = "";
  var bgColor = Colors.black;
  var textColor = Colors.white;

  bool _showBPInfo = false;

  void _toggleBPInfo() {
    setState(() {
      _showBPInfo = !_showBPInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(150, 0, 0, 0),
        title: const Text(
          "Blood Pressure (BP) Calculator",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info, color: Colors.white),
            onPressed: _toggleBPInfo,
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
                    'Blood Pressure (BP) Calculator',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 21),
                  TextField(
                    controller: systolicController,
                    decoration: InputDecoration(
                      labelText: "Enter Systolic Pressure (Upper)",
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(color: textColor)),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 11),
                  TextField(
                    controller: diastolicController,
                    decoration: InputDecoration(
                      labelText: "Enter Diastolic Pressure (Lower)",
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(color: textColor)),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      var systolicPressure = int.tryParse(systolicController.text) ?? 0;
                      var diastolicPressure = int.tryParse(diastolicController.text) ?? 0;

                      if (systolicPressure != 0 && diastolicPressure != 0) {
                        var bpCategory = calculateBP(systolicPressure, diastolicPressure);
                        setState(() {
                          if (bpCategory == "High") {
                            bgColor = Colors.red;
                            textColor = Colors.white;
                          } else if (bpCategory == "Low") {
                            bgColor = Colors.blue;
                            textColor = Colors.white;
                          } else if (bpCategory == "Normal") {
                            bgColor = Colors.green;
                            textColor = Colors.black;
                          } else if (bpCategory == "Type 1") {
                            bgColor = Colors.orange;
                            textColor = Colors.black;
                          } else if (bpCategory == "Type 2") {
                            bgColor = Colors.yellow;
                            textColor = Colors.black;
                          } else if (bpCategory == "Low") {
                            bgColor = Colors.blue;
                            textColor = Colors.white;
                          }
                          result = "Your Blood Pressure Category: $bpCategory";
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
                  if (_showBPInfo)
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Blood Pressure (BP) Categories:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Normal: Systolic < 120 mmHg and Diastolic < 80 mmHg',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'High: Systolic >= 140 mmHg or Diastolic >= 90 mmHg',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Low: Systolic < 90 mmHg or Diastolic < 60 mmHg',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Type 1: Systolic > 180 mmHg or Diastolic > 120 mmHg',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Type 2: Systolic > 160 mmHg or Diastolic > 100 mmHg',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Note: The result indicates the category of blood pressure based on the entered values.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 19, color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 45,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Calculate Blood Pressure Category
  String calculateBP(int systolic, int diastolic) {
    if (systolic >= 140 || diastolic >= 90) {
      return "High";
    } else if (systolic < 90 || diastolic < 60) {
      return "Low";
    } else if (systolic > 180 || diastolic > 120) {
      return "Type 1";
    } else if (systolic > 160 || diastolic > 100) {
      return "Type 2";
    } else if (systolic < 90 || diastolic < 60) {
      return "Low";
    } else {
      return "Normal";
    }
  }
}
