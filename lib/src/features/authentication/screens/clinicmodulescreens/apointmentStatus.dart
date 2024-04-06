// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAppointmentsScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

UserAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    if (user == null) {
      return const Center(child: Text('Please log in to view appointments.'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Appointments', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .where('userId', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No appointments found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];

              // Ensure data is a Map before accessing keys
              if (doc.data() is Map<String, dynamic>) {
                final data = doc.data() as Map<String, dynamic>;

                return AppointmentCard(
                  doctorName: data['doctorName'],
                  selectedDate: data['selectedDate'],
                  selectedTime: data['selectedTime'],
                  paymentMethod: data['paymentMethod'],
                  appointmentType: data['appointmentType'],
                  onCancel: () async {
                    await FirebaseFirestore.instance.runTransaction((transaction) async {
                      transaction.delete(doc.reference);
                    });
                  },
                );
              } else {
                // Handle case where data is not a Map (e.g., log an error)
                print('Unexpected data type for appointment: ${doc.data().runtimeType}');
                return const SizedBox.shrink(); // Or display an error message
              }
            },
          );
        },
      ),
    );
  }
}
class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final Timestamp selectedDate;
  final String selectedTime;
  final String paymentMethod;
  final String appointmentType;
  final VoidCallback onCancel;

  const AppointmentCard({
    Key? key, 
    required this.doctorName,
    required this.selectedDate,
    required this.selectedTime,
    required this.paymentMethod,
    required this.appointmentType,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final dateTime = selectedDate.toDate();
    final formattedDate = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    final formattedTime = _formatTime(dateTime);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Doctor Name: $doctorName',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 8),
            Text('Selected Date: $formattedDate'),
            Text('Selected Time: $selectedTime'),
            Text('Payment Method: $paymentMethod'),
            Text('Appointment Type: $appointmentType'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                // Show an alert dialog for confirmation
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Cancel'),
                      content: const Text('Are you sure you want to cancel this appointment?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            // Close the alert dialog
                            Navigator.of(context).pop();
                            // Show a scaffold message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Cancelling appointment...'),
                              ),
                            );
                            // Call the onCancel function
                            onCancel();
                            // Show a scaffold message after cancellation
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Appointment cancelled successfully.'),
                              ),
                            );
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Close the alert dialog
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
              ),    
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.cancel_outlined, color: Colors.white,),
                  SizedBox(width: 10),  // gives some space between the icon and the text
                  Text('Cancel Appointment', style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to format time
  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = '${dateTime.minute}'.padLeft(2, '0');
    final period = dateTime.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
