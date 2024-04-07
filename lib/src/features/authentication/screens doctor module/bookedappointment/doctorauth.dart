import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class DoctorVerificationScreen extends StatefulWidget {
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

  List<String> errorMessages = [];
  bool isLoading = false;

  Future<void> verifyDoctorData() async {
    setState(() {
      isLoading = true;
      errorMessages.clear();
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
          isLoading = false;
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The data you entered is correct. Please wait...'),
            duration: Duration(seconds: 2),
          ),
        );

        // Delay navigation to another screen
        await Future.delayed(Duration(seconds: 2));

        // Navigate to another screen
        // Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentsScreen()));
      } else {
        // Data is incorrect
        if (providedDoctorName.isEmpty) {
          errorMessages.add('Doctor Name is required.');
        }
        if (providedPhoneNumber.isEmpty) {
          errorMessages.add('Phone Number is required.');
        }
        if (providedLicenseNumber.isEmpty) {
          errorMessages.add('License Number is required.');
        }
        if (providedEmail.isEmpty) {
          errorMessages.add('Email is required.');
        }

        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error verifying data: $error');
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: doctorNameController,
              decoration: const InputDecoration(labelText: 'Doctor Name'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: licenseNumberController,
              decoration: const InputDecoration(labelText: 'License Number'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: isLoading ? null : verifyDoctorData,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Verify'),
            ),
            const SizedBox(height: 20.0),
            if (errorMessages.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: errorMessages
                    .map((message) => Text(
                          message,
                          style: const TextStyle(color: Colors.red),
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}


