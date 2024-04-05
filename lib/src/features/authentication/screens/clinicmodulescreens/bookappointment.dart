// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookAppointmentPage extends StatefulWidget {
  final String docId;

  const BookAppointmentPage({Key? key, required this.docId}) : super(key: key);

  @override
  _BookAppointmentPageState createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  late Map<String, List<String>> _availableTimes = {};
  late DateTime _selectedDate;
  late String _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _fetchDoctorData();
  }

  Future<void> _fetchDoctorData() async {
    final snapshot = await FirebaseFirestore.instance.collection('doctors').doc(widget.docId).get();
    if (snapshot.exists) {
      final doctorData = snapshot.data() as Map<String, dynamic>;
      final workingHours = doctorData['workingHours'] as String?;
      final List<dynamic>? availableDays = doctorData['availableDays'] as List<dynamic>?;
      if (workingHours != null && availableDays != null) {
        _generateAvailableTimes(workingHours, availableDays);
      }
    }
  }

  void _generateAvailableTimes(String workingHours, List<dynamic> availableDays) {
    final daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final hours = workingHours.split('-');
    final startHour = int.parse(hours[0].split(':')[0]);
    final endHour = int.parse(hours[1].split(':')[0]);

    final availableDaysMap = Map<String, List<String>>.fromIterable(daysOfWeek, key: (day) => day, value: (_) => []);

    for (var i = 0; i < availableDays.length; i++) {
      if (availableDays[i]) {
        final currentDate = DateTime.now();
        final currentDay = currentDate.add(Duration(days: i)).weekday;
        final currentTime = DateTime(currentDate.year, currentDate.month, currentDate.day, startHour);
        while (currentTime.hour < endHour) {
          availableDaysMap[DateFormat('EEEE').format(currentTime)]?.add(DateFormat.Hm().format(currentTime));
          currentTime.add(const Duration(minutes: 15)); // Changed to 15 minutes slot
        }
      }
    }
    setState(() {
      _availableTimes = availableDaysMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              trailing: ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _selectedDate = selectedDate;
                    });
                  }
                },
                child: const Text('Select Date'),
              ),
            ),
            const SizedBox(height: 20.0),
            _buildAvailableTimeSlots(),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                final selectedDateTime = _getSelectedDateTime();
                if (selectedDateTime != null) {
                  await _bookAppointment(selectedDateTime);
                } else {
                  Get.snackbar('Error', 'Please select a time slot');
                }
              },
              child: const Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableTimeSlots() {
    final selectedDay = DateFormat('EEEE').format(_selectedDate);
    final timesForSelectedDay = _availableTimes[selectedDay] ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Time Slot:',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8.0,
          children: timesForSelectedDay.map<Widget>((time) {
            return ChoiceChip(
              label: Text(time),
              selected: _selectedTime == time,
              onSelected: (isSelected) {
                if (isSelected) {
                  setState(() {
                    _selectedTime = time;
                  });
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  DateTime? _getSelectedDateTime() {
    return _selectedTime != null
        ? DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, int.parse(_selectedTime.split(':')[0]),
            int.parse(_selectedTime.split(':')[1]))
        : null;
  }

  Future<void> _bookAppointment(DateTime selectedDateTime) async {
    await FirebaseFirestore.instance.collection('appointments').add({
      'date': selectedDateTime,
      'doctorId': widget.docId,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
    Get.snackbar('Success', 'Appointment booked successfully');
  }
}
