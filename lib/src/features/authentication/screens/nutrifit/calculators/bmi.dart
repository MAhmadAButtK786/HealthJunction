import 'package:flutter/material.dart';
class BMICalculator extends StatefulWidget {
  BMICalculator({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  void _handleMenuPressed() {
    widget.scaffoldKey.currentState?.openDrawer();
  }

  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var result = "";
  var bgColor = Colors.black;
  var borderColor = Colors.white;
  var weightUnit = 'kg';
  var heightUnit = 'm';

  bool _showBMIInfo = false;

  void _toggleBMIInfo() {
    setState(() {
      _showBMIInfo = !_showBMIInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
       backgroundColor: const Color.fromARGB(150, 0, 0, 0),
       
        title: const Text("BMI Calculator",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          actions: [
          IconButton(
            icon: const Icon(Icons.info, color: Colors.white,),
            onPressed: _toggleBMIInfo,
          ),]
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
                    'Body Mass Index',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 21),
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
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      var weight = double.tryParse(wtController.text) ?? 0;
                      var feet = double.tryParse(ftController.text) ?? 0;
                      var inches = double.tryParse(inController.text) ?? 0;

                      double height;
                      if (heightUnit == 'ft') {
                        height = feet + (inches / 12);
                      } else {
                        height = feet * 0.3048; // Convert feet to meters
                      }

                      if (weight != 0 && height != 0) {
                        var bmi = calculateBMI(weight, height, weightUnit, heightUnit);
                        var msg = "";
                        if(bmi>=30){
                          msg="You are facing obesity!!";
                          bgColor = Colors.red.shade900;
                        }
                        if (bmi >= 25 && bmi<30) {
                          msg = "You're Overweight!!";
                          bgColor = Colors.red;
                        } else if (bmi < 18.5) {
                          msg = "You're UnderWeight!!";
                          bgColor = Colors.orange;
                        } else if(bmi<=18.5 && bmi <25) {
                          msg = "You're Healthy!!";
                          bgColor = Colors.green;
                        }

                        setState(() {
                          result = "$msg \n Your Body Mass Index : ${bmi.toStringAsFixed(2)}";
                          borderColor = bgColor; // Border color reflects result color
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
                if (_showBMIInfo)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'BMI Categories:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text('Underweight: BMI < 18.5', style: TextStyle(color: Colors.white)),
                        const Text('Normal weight: 18.5 <= BMI < 25', style: TextStyle(color: Colors.white)),
                        const Text('Overweight: 25 <= BMI < 30', style: TextStyle(color: Colors.white)),
                        const Text('Obesity: BMI >= 30', style: TextStyle(color: Colors.white)),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Note: BMI is calculated using the following formula:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'BMI = (Weight in ${weightUnit.toUpperCase()} / (Height in ${heightUnit.toUpperCase()} * Height in ${heightUnit.toUpperCase()}))',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'For example, if your weight is in ${weightUnit.toUpperCase()} and height is in ${heightUnit.toUpperCase()}, '
                          'the formula will be applied accordingly.',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 19, color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Calculate BMI
  double calculateBMI(double weight, double height, String weightUnit, String heightUnit) {
    double bmi;
    // Convert weight to kilograms if unit is 'lb'
    if (weightUnit == 'lb') {
      weight = weight * 0.453592; // 1 lb = 0.453592 kg
    }
    // Convert height to meters if unit is 'ft'
    if (heightUnit == 'ft') {
      height = height * 0.3048; // 1 ft = 0.3048 m
    }

    // Calculate BMI
    bmi = weight / (height * height);
    return bmi;
  }
}
