import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/features/authentication/screens%20doctor%20module/bookedappointment/docappointment.dart';

class DoctorVerificationScreen extends StatefulWidget {
  const DoctorVerificationScreen({Key? key}) : super(key: key);

  @override
  _DoctorVerificationScreenState createState() =>
      _DoctorVerificationScreenState();
}

class _DoctorVerificationScreenState extends State<DoctorVerificationScreen> {
  TextEditingController doctorNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool? isDataCorrect;
  bool isLoading = false;

  Future<void> verifyDoctorData() async {
    setState(() {
      isLoading = true;
    });

    String providedDoctorName = doctorNameController.text;
    String providedPhoneNumber = phoneNumberController.text;
    String providedLicenseNumber = licenseNumberController.text;
    String providedEmail = emailController.text;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('doctors')
          .where('fullName', isEqualTo: providedDoctorName)
          .where('phoneNumber', isEqualTo: providedPhoneNumber)
          .where('licenseNumber', isEqualTo: providedLicenseNumber)
          .where('email', isEqualTo: providedEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Data is correct
        setState(() {
          isDataCorrect = true;
          isLoading = false;
        });

        // Extract doctor data
        String doctorId = querySnapshot.docs[0].id;
        String doctorName = querySnapshot.docs[0]['fullName'];

        // Navigate to another screen with correct data
        Get.to(() => DoctorAppointmentsScreen(
              doctorId: doctorId,
              doctorName: doctorName,
            ));
      } else {
        // Data is incorrect
        setState(() {
          isDataCorrect = false;
          isLoading = false;
        });
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error verifying data: $error');
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Doctor Appointments',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
        ),
        backgroundColor: Colors.teal, // Add teal color to app bar
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(backver),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), // Adjust the background image opacity
                BlendMode.darken,
              ),
            ),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Verify to proceed with Appointments',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25, // Increase the font size
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto', // Use a custom font
                  shadows: [
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(2.0, 2.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: doctorNameController,
                decoration: InputDecoration(
                  labelText: 'Doctor Name',
                  prefixIcon: const Icon(FontAwesomeIcons.userDoctor),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.7), 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: const Icon(Icons.phone),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: licenseNumberController,
                decoration: InputDecoration(
                  labelText: 'License Number',
                  prefixIcon: const Icon(Icons.assignment_ind),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : verifyDoctorData,
                // ignore: sort_child_properties_last
                child: isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                                'Verify Data',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                ),
                              ),
                          ],
                        ),
                      ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Add more rounded corners to the button
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (isDataCorrect != null)
                Text(
                  isDataCorrect!
                      ? 'Data is correct. Navigating to another screen...'
                      : 'Data is incorrect. Please check your input.',
                  style: TextStyle(
                    color: isDataCorrect != null
                        ? (isDataCorrect! ? Colors.green : Colors.red)
                        : Colors.black,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
