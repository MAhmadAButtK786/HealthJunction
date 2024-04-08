// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/image_string.dart';

class BookingDateTimeScreen extends StatefulWidget {
  final String doctorName;
  final String doctorId;

  const BookingDateTimeScreen({
    Key? key,
    required this.doctorName,
    required this.doctorId, required List<String> availableDays,
  }) : super(key: key);

  @override
  _BookingDateTimeScreenState createState() => _BookingDateTimeScreenState();
}

class _BookingDateTimeScreenState extends State<BookingDateTimeScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedAppointmentType = '';
  String _selectedPaymentMethod = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _bookAppointment() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      if (_nameController.text.isEmpty ||
          _ageController.text.isEmpty ||
          _selectedAppointmentType.isEmpty ||
          _selectedPaymentMethod.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red, // Error color
        ));
        return;

      }
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Appointment'),
            content: Text('Are you sure you want to book an appointment with ${widget.doctorName}?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              
              TextButton(
                onPressed: () async {
                  await _firestore.collection('appointments').add({
                    'userId': user.uid,
                    'doctorId': widget.doctorId,
                    'doctorName': widget.doctorName,
                    'patientName': _nameController.text,
                    'patientAge': _ageController.text,
                    'selectedDate': selectedDate,
                    'selectedTime': selectedTime.format(context),
                    'appointmentType': _selectedAppointmentType,
                    'paymentMethod': _selectedPaymentMethod,
                  });
                  Get.snackbar('Success', 'Appointment booked successfully',
                      backgroundColor: Colors.green, // Success color
                      colorText: Colors.white); // Text color
                  Navigator.of(context).pop();
                
                },
                child: const Text('Confirm'),
              ),
              
            ],
          );
        },
        
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Book Appointment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal, // Teal color
      ),
      body: SingleChildScrollView(
        
     
          child: Container(
             decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(docback),
              fit: BoxFit.cover,
              opacity: 0.3
            ),
          ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("Book Appointment with ${widget.doctorName}",style: GoogleFonts.montserrat(fontWeight:FontWeight.bold,fontSize:25,color:Colors.teal),),),
               const SizedBox(height: 14,),
                const Row(
                  children: [
                    Icon(FontAwesomeIcons.userInjured, color: Colors.teal,),
                    SizedBox(width: 5,),
                    Text(
                      'Patient Information',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Patient Name',
                    prefixIcon: Icon(FontAwesomeIcons.idCard),
                  
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Patient Age',
                   prefixIcon: Icon(Icons.date_range),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(FontAwesomeIcons.calendar,color: Colors.teal,),
                    SizedBox(width: 5,),
                    Text(
                      'Select Date and Time',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Teal color
                  ),
                  child: const Text('Select Date', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height:10),
                 Text(
                'Selected Date: ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green.shade700),
              ),
                
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Teal color
                  ),
                  child: const Text('Select Time', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 10,),
                 Text(
                'Selected Time: ${selectedTime.hour}:${selectedTime.minute}',
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green.shade700),
              ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(FontAwesomeIcons.check,color: Colors.teal,),   
                     SizedBox(width: 5,),  
                    Text(
                      'Select Appointment Type',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedAppointmentType.isNotEmpty ? _selectedAppointmentType : null,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedAppointmentType = newValue!;
                    });
                  },
                  items: ['Visit Clinic', 'Online Meeting'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Appointment Type',
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(FontAwesomeIcons.wallet,color: Colors.teal,),   
                     SizedBox(width: 5,),  
                     Text(
                      'Select Payment Method',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedPaymentMethod.isNotEmpty ? _selectedPaymentMethod : null,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedPaymentMethod = newValue!;
                    });
                  },
                  items: ['Charity', 'Cash on Visit', 'Online Transfer'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Payment Method',
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _bookAppointment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Green color
                    ),
                    child: const Center(
                      child: Row(
                        children: [
                          SizedBox(width: 36,),
                          Icon(FontAwesomeIcons.bookMedical,color: Colors.white,),
                          SizedBox(width: 5,),
                         
                          Text('Book Appointment', style: TextStyle(color: Colors.white,fontSize: 20),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

class UserAppointmentsScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    if (user == null) {
      return const Center(child: Text('Please log in to view appointments.'));
    }

    return StreamBuilder<QuerySnapshot>(
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
            return Column(
              children: [
                ListTile(
                  title: Text('Appointment with ${doc['doctorName']}'),
                  subtitle: Text('Date: ${doc['selectedDate']} Time: ${doc['selectedTime']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () async {
                      await FirebaseFirestore.instance.runTransaction((transaction) async {
                        transaction.delete(doc.reference);
                      });
                    },
                  ),
                ),
                const Divider(),
              ],
            );
          },
        );
      },
    );
  }
}
