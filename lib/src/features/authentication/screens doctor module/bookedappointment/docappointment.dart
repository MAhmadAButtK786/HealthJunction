// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/features/authentication/screens%20doctor%20module/doctorhome/dochome.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorAppointmentsScreen extends StatelessWidget {
  final String doctorId;
  final String doctorName;

  const DoctorAppointmentsScreen({
    Key? key,
    required this.doctorId,
    required this.doctorName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String doctorName = this.doctorName; // Declare local variable

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(' Welcome $doctorName', style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          actions: [IconButton
          (onPressed: (){ Get.to(()=> const DoctorHome());}, 
          icon: const Icon(Icons.home_filled, color: Colors.white,))],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('appointments')
              .where('doctorId', isEqualTo: doctorId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
      
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No appointments found for $doctorName.'));
            }
      
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final appointmentData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                final dateTime = (appointmentData['selectedDate'] as Timestamp).toDate();
                final formattedDate = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
                _formatTime(dateTime);
      
                return AppointmentCard(
                  patientName: appointmentData['patientName'],
                  selectedDate: formattedDate,
                  selectedTime: appointmentData['selectedTime'] ,
                  paymentMethod: appointmentData['paymentMethod'] ?? 'N/A',
                  appointmentType: appointmentData['appointmentType'] ?? 'N/A',
                  onDelete: () {
                    _showCancelConfirmationDialog(context, snapshot.data!.docs[index].id);
                  },
                );
              },
            );
          },
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

  
void _showCancelConfirmationDialog(BuildContext context, String appointmentId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Cancel Appointment'),
        content: const Text('Are you sure you want to cancel this appointment?',style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              _deleteAppointment(context, appointmentId);
              Navigator.of(context).pop(); 
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}


  // Function to delete appointment and show confirmation message
  void _deleteAppointment(BuildContext context, String appointmentId) {
    FirebaseFirestore.instance.collection('appointments').doc(appointmentId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Appointment deleted successfully'),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String patientName;
  final String selectedDate;
  final String selectedTime;
  final String paymentMethod;
  final String appointmentType;
  final VoidCallback onDelete;

  const AppointmentCard({
    Key? key,
    required this.patientName,
    required this.selectedDate,
    required this.selectedTime,
    required this.paymentMethod,
    required this.appointmentType,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              'Patient Name: $patientName',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 8),
            Text('Appointment Date: $selectedDate'),
            Text('Appointment Time: $selectedTime'),
            Text('Payment Method: $paymentMethod'),
            Text('Appointment Type: $appointmentType'),
            const SizedBox(height: 8),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _setEventInCalendar(selectedDate, selectedTime, patientName);
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Add to Calendar'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.teal,
                  ),
                ),
                
                 ElevatedButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.cancel),
                  label: const Text('Cancel the Appointment'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
Future<void> _setEventInCalendar(String date, String time, String patientName) async {
  // Parse the date and time components
  final List<String> dateComponents = date.split('/');
  final List<String> timeComponents = time.split(':');

  // Extract year, month, day, hour, and minute from date and time components
  final int year = int.parse(dateComponents[2]);
  final int month = int.parse(dateComponents[1]);
  final int day = int.parse(dateComponents[0]);
  int hour = int.parse(timeComponents[0]);
  final int minute = int.parse(timeComponents[1].split(' ')[0]); // Extract minute without ' AM' or ' PM'

  // Convert AM/PM time to 24-hour format
  if (timeComponents[1].contains('PM') && hour < 12) {
    hour += 12;
  } else if (timeComponents[1].contains('AM') && hour == 12) {
    hour = 0;
  }

  // Create DateTime object
  final DateTime dateTime = DateTime(year, month, day, hour, minute);

  // Format date and time for the URL
  final formattedDate = '$year${month.toString().padLeft(2, '0')}${day.toString().padLeft(2, '0')}T' +
      '${hour.toString().padLeft(2, '0')}${minute.toString().padLeft(2, '0')}00Z';

  final encodedEventName = Uri.encodeComponent('$patientName Appointment');

  // Construct the calendar URL with event details
  final calendarUrl = 'https://calendar.google.com/calendar/r/eventedit?text=$encodedEventName&dates=$formattedDate/$formattedDate&ctz=UTC';

  // Launch the calendar URL
  if (await canLaunch(calendarUrl)) {
    await launch(calendarUrl);
  } else {
    throw 'Could not launch $calendarUrl';
  }
}
}