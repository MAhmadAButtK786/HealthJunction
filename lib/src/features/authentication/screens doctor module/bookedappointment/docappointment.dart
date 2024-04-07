import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return Scaffold(
      appBar: AppBar(
        // ignore: unnecessary_string_interpolations
        title: Text('$doctorName'),
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
                selectedTime: appointmentData['selectedTime'],
                paymentMethod: appointmentData['paymentMethod'],
                appointmentType: appointmentData['appointmentType'],
              );
            },
          );
        },
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

class AppointmentCard extends StatelessWidget {
  final String patientName;
  final String selectedDate;
  final String selectedTime;
  final String paymentMethod;
  final String appointmentType;

  const AppointmentCard({
    Key? key,
    required this.patientName,
    required this.selectedDate,
    required this.selectedTime,
    required this.paymentMethod,
    required this.appointmentType,
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
            Text('Selected Date: $selectedDate'),
            Text('Selected Time: $selectedTime'),
            Text('Payment Method: $paymentMethod'),
            Text('Appointment Type: $appointmentType'),
          ],
        ),
      ),
    );
  }
}
