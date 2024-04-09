import 'package:flutter/material.dart';

class DiabetesCalculator extends StatefulWidget {
  DiabetesCalculator({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<DiabetesCalculator> createState() => _DiabetesCalculatorState();
}

class _DiabetesCalculatorState extends State<DiabetesCalculator> {
  void _handleMenuPressed() {
    widget.scaffoldKey.currentState?.openDrawer();
  }

  var fastingController = TextEditingController();
  var ppController = TextEditingController();
  var result = "";
  var bgColor = Colors.black;
  var textColor = Colors.white;

  bool _showDiabetesInfo = false;

  void _toggleDiabetesInfo() {
    setState(() {
      _showDiabetesInfo = !_showDiabetesInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(150, 0, 0, 0),
        title: const Text(
          "Diabetes Calculator",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info, color: Colors.white),
            onPressed: _toggleDiabetesInfo,
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
                    'Diabetes Calculator',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 21),
                  TextField(
                    controller: fastingController,
                    decoration: InputDecoration(
                      labelText: "Enter Fasting Blood Sugar Level",
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(color: textColor)),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 11),
                  TextField(
                    controller: ppController,
                    decoration: InputDecoration(
                      labelText: "Enter Postprandial Blood Sugar Level",
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(color: textColor)),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      var fastingSugar = int.tryParse(fastingController.text) ?? 0;
                      var ppSugar = int.tryParse(ppController.text) ?? 0;

                      if (fastingSugar != 0 && ppSugar != 0) {
                        var diabetesCategory = calculateDiabetes(fastingSugar, ppSugar);
                        setState(() {
                          if (diabetesCategory == "Diabetes") {
                            bgColor = Colors.red;
                            textColor = Colors.white;
                          } else if (diabetesCategory == "Pre-Diabetes") {
                            bgColor = Colors.orange;
                            textColor = Colors.black;
                          } else if (diabetesCategory == "Normal") {
                            bgColor = Colors.green;
                            textColor = Colors.black;
                          } else if (diabetesCategory == "Low") {
                            bgColor = Colors.blue;
                            textColor = Colors.white;
                          }
                          result = "Your Diabetes Status: $diabetesCategory";
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
                  if (_showDiabetesInfo)
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Diabetes Status Categories:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Normal: Fasting < 100 mg/dL and Postprandial < 140 mg/dL',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Pre-Diabetes: Fasting 100-125 mg/dL or Postprandial 140-199 mg/dL',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Diabetes: Fasting >= 126 mg/dL or Postprandial >= 200 mg/dL',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Low: Fasting < 70 mg/dL or Postprandial < 100 mg/dL',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Note: The result indicates the diabetes status based on the entered values.',
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

  // Calculate Diabetes Status
  String calculateDiabetes(int fasting, int pp) {
    if (fasting >= 126 || pp >= 200) {
      return "Diabetes";
    } else if ((fasting >= 100 && fasting <= 125) || (pp >= 140 && pp <= 199)) {
      return "Pre-Diabetes";
    } else if (fasting < 70 || pp < 100) {
      return "Low";
    } else {
      return "Normal";
    }
  }
}
