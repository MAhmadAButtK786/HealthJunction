import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthjunction/src/features/authentication/screens%20doctor%20module/bookedappointment/docappointment.dart';

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

        // Navigate to another screen
         Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorAppointmentsScreen(doctorId: '', doctorName: '',)));
      } else {
        // Data is incorrect
        setState(() {
          isDataCorrect = false;
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
        title: Text('Doctor Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: doctorNameController,
              decoration: InputDecoration(labelText: 'Doctor Name'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: licenseNumberController,
              decoration: InputDecoration(labelText: 'License Number'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: isLoading ? null : verifyDoctorData,
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text('Verify'),
            ),
            SizedBox(height: 20.0),
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
    );
  }
}

