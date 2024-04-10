import 'package:flutter/material.dart';

class ExerciseCaloriesBurnCalculator extends StatefulWidget {
  ExerciseCaloriesBurnCalculator({Key? key}) : super(key: key);

  @override
  _ExerciseCaloriesBurnCalculatorState createState() =>
      _ExerciseCaloriesBurnCalculatorState();
}

class _ExerciseCaloriesBurnCalculatorState
    extends State<ExerciseCaloriesBurnCalculator> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String selectedExercise = 'Running'; // Default exercise

  TextEditingController timeController = TextEditingController();

  // Map of exercises and their corresponding calories burned per minute
  Map<String, double> exerciseCaloriesMap = {
    'Running': 10,
    'Cycling': 8,
    'Swimming': 12,
    'Jumping Rope': 15,
    'Walking': 5,
    'Yoga': 4,
    'Dancing': 7,
    'Hiking': 9,
    'Boxing': 14,
    'Jumping Jacks': 11,
    'Rowing': 10,
    'Rock Climbing': 12,
    'Kickboxing': 13,
    'Pilates': 6,
    'Tai Chi': 5,
    'Zumba': 8,
    'Soccer': 10,
    'Basketball': 12,
    'Tennis': 11,
    'Volleyball': 8,
    'Gardening': 5,
    'Skating': 9,
    'Skiing': 13,
    'Snowboarding': 12,
    'Ice Skating': 10,
    'Martial Arts': 14,
    'Surfing': 11,
    'Racquetball': 12,
    'Golfing': 6,
    'High-Intensity Interval Training (HIIT)': 13,
    'Plyometrics': 14,
    'CrossFit': 15,
    'Circuit Training': 10,
    'Stair Climbing': 12,
    'Calisthenics': 8,
    'Bodyweight Exercises': 7,
    'Barre': 6,
    'Paddleboarding': 9,
    'Squash': 13,
    'Kickball': 10,
    'Handball': 12,
    'Ultimate Frisbee': 9,
    'Rock Climbing (Indoor)': 11,
    'Bowling': 4,
  };

  double caloriesBurned = 0;

  bool _showExerciseInfo = false;

  void _toggleExerciseInfo() {
    setState(() {
      _showExerciseInfo = !_showExerciseInfo;
    });
  }

  void _resetCalculator() {
    setState(() {
      selectedExercise = 'Running';
      timeController.text = '';
      caloriesBurned = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
      backgroundColor: const Color.fromARGB(150, 0, 0, 0),
        title: const Text(
          'FitFocus Finder',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
         
        actions: [
          IconButton(
            icon: const Icon(Icons.info, color:Colors.white),
            onPressed: _toggleExerciseInfo,
          ),
        ],
      ),
      // Set scaffold background color to black
      body: SingleChildScrollView(
        
       
        child: Container(
        color: Colors.black,
         padding: const EdgeInsets.all(20),
      
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40,),
              const Text(
                'Welcome to FitFocus Finder!',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 26),
              const Text(
                'Select Exercise:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10,),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.black,
                value: selectedExercise,
                onChanged: (value) {
                  setState(() {
                    selectedExercise = value!;
                  });
                },
                items: exerciseCaloriesMap.keys.map((exercise) {
                  return DropdownMenuItem<String>(
                    value: exercise,
                    child: Text(
                      exercise,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              const Text(
                'Enter Time (minutes):',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
               const SizedBox(height: 10,),
              TextField(
                controller: timeController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  calculateCaloriesBurned();
                },
                child: const Text('Calculate',),
              ),
              const SizedBox(height: 35),
              Text(
                'Calories Burned: ${caloriesBurned.toStringAsFixed(2)} kcal',
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              if (_showExerciseInfo)
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exercise Information:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1. Regular exercise helps improve overall health and fitness.',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '2. Aim for at least 150 minutes of moderate-intensity exercise per week.',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '3. Exercises like running, swimming, and cycling are great for cardiovascular health.',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '4. Strength training exercises help build muscle mass and increase metabolism.',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '5. Listen to your body and avoid overexertion or pushing through pain.',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '6. Stay hydrated before, during, and after exercising.',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '7. Warm up before exercising to prevent injury and cool down afterward to aid recovery.',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '8. Incorporate variety into your workout routine to prevent boredom and plateaus.',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '9. Consult with a healthcare professional before starting a new exercise program, especially if you have any underlying health conditions.',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '10. Have fun and enjoy the process of staying active!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetCalculator,
        backgroundColor: Colors.white,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void calculateCaloriesBurned() {
    double time = double.tryParse(timeController.text) ?? 0;
    double caloriesPerMinute = exerciseCaloriesMap[selectedExercise] ?? 0;
    setState(() {
      caloriesBurned = time * caloriesPerMinute;
    });
  }
}

