import 'package:flutter/material.dart';

class ExerciseCaloriesBurn extends StatefulWidget {
  ExerciseCaloriesBurn({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<ExerciseCaloriesBurn> createState() => _ExerciseCaloriesBurnState();
}

class _ExerciseCaloriesBurnState extends State<ExerciseCaloriesBurn> {
  var selectedExercise;
  var durationController = TextEditingController();
  var result = "";
  var bgColor = Colors.black;
  var borderColor = Colors.white;

  final Map<String, double> exerciseCalorieBurnRates = {
  "Running": 10.0, // 10 calories per minute
  "Cycling": 8.0, // 8 calories per minute
  "Swimming": 12.0, // 12 calories per minute
  "Jumping Rope": 15.0, // 15 calories per minute
  "Walking": 5.0, // 5 calories per minute
  "Yoga": 3.0, // 3 calories per minute
  "Weightlifting": 4.0, // 4 calories per minute
  "Dancing": 7.0, // 7 calories per minute
  "Hiking": 6.0, // 6 calories per minute
  "Rowing": 9.0, // 9 calories per minute
  "Stair Climbing": 11.0, // 11 calories per minute
  "Pilates": 4.0, // 4 calories per minute
  "Tai Chi": 3.0, // 3 calories per minute
  "Soccer": 10.0, // 10 calories per minute
  "Basketball": 8.0, // 8 calories per minute
  "Volleyball": 6.0, // 6 calories per minute
  "Tennis": 7.0, // 7 calories per minute
  "Gardening": 5.0, // 5 calories per minute
  "Rock Climbing": 12.0, // 12 calories per minute
  "Surfing": 9.0, // 9 calories per minute
  "Martial Arts": 10.0, // 10 calories per minute
  "Boxing": 13.0, // 13 calories per minute
  "Golf": 4.0, // 4 calories per minute
  "Skating": 6.0, // 6 calories per minute
  "Skiing": 7.0, // 7 calories per minute
  "Snowboarding": 8.0, // 8 calories per minute
  "Ice Skating": 10.0, // 10 calories per minute
  "Kayaking": 8.0, // 8 calories per minute
  "Paddleboarding": 6.0, // 6 calories per minute
  "Frisbee": 5.0, // 5 calories per minute
  "Racquetball": 9.0, // 9 calories per minute
  "Bowling": 3.0, // 3 calories per minute
  
};


final List<String> exercises = [
  "Running",
  "Cycling",
  "Swimming",
  "Jumping Rope",
  "Walking",
  "Yoga",
  "Weightlifting",
  "Dancing",
  "Hiking",
  "Rowing",
  "Stair Climbing",
  "Pilates",
  "Tai Chi",
  "Soccer",
  "Basketball",
  "Volleyball",
  "Tennis",
  "Gardening",
  "Rock Climbing",
  "Surfing",
  "Martial Arts",
  "Boxing",
  "Golf",
  "Skating",
  "Skiing",
  "Snowboarding",
  "Ice Skating",
  "Kayaking",
  "Paddleboarding",
  "Frisbee",
  "Racquetball",
  "Bowling",
 
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(150, 0, 0, 0),
        title: const Text(
          "Exercise Calories Burn",
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
                    'Exercise Calories Burn',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 21),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Select Exercise",
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                    ),
                    value: selectedExercise,
                    onChanged: (value) {
                      setState(() {
                        selectedExercise = value;
                      });
                    },
                    items: exercises.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 11),
                  TextField(
                    controller: durationController,
                    decoration: InputDecoration(
                      labelText: "Duration (in minutes)",
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      var duration = int.tryParse(durationController.text) ?? 0;

                      if (selectedExercise != null && duration != 0) {
                        var caloriesBurned = calculateCaloriesBurned(selectedExercise, duration);
                        setState(() {
                          result = "Calories Burned: ${caloriesBurned.toStringAsFixed(2)} kcal";
                          borderColor = Colors.green; // Border color reflects result color
                          durationController.clear();
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select an exercise and enter valid duration.'),
                          ),
                        );
                      }
                    },
                    child: const Text('Calculate'),
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

  double calculateCaloriesBurned(String exercise, int duration) {
    // This function calculates calories burned based on the selected exercise and duration.
    // We use the predefined calorie burn rates for different exercises.
    var calorieBurnRate = exerciseCalorieBurnRates[exercise] ?? 5.0; // Default to 5 calories per minute if exercise not found
    return calorieBurnRate * duration;
  }
}
