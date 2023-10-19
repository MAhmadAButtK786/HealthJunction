// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_field, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/bloodbank/blooddonor/donor_form/donor_form.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_screen/profile_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SearchRecipient extends StatefulWidget {
  const SearchRecipient({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<SearchRecipient> createState() => _SearchRecipientState();
}

class _SearchRecipientState extends State<SearchRecipient> {
  final _formKey = GlobalKey<FormState>();
  String _selectedBloodGroup = 'A+';
  final _citynameController = TextEditingController();
  final _provincenameController = TextEditingController();
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    if (isDarkMode) {
      backgroundColor = Colors.red.shade200;
    } else {
      backgroundColor = Colors.red.shade200;
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              LineAwesomeIcons.angle_left,
              color: tWhiteColor,
            ),
          ),
          title: Text(
            tBloodBank,
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => ProfileScreen());
                },
                icon: Icon(Icons.person))
          ],
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: backgroundColor,
          padding: EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(children: [
              Text(
                tRecipientSearch,
                style: GoogleFonts.inter(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(
                height: 25,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  labelText: "Select Your Province",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                items: <String>[
                  'Punjab',
                  'Sindh',
                  'Khyber Pakhtunkhwa',
                  'Balochistan',
                  'Gilgit-Baltistan'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Do something with the selected value
                },
              ),
              Form(
                child: Column(
                  children: [
                    //Province

                    SizedBox(
                      height: 15,
                    ),
                    //city
                    TextFormField(
                      controller: _citynameController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.location_city,
                            color: Colors.white,
                          ),
                          labelText: "City Name",
                          hintText: "Enter The Name of Your City",
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelStyle: TextStyle(color: Colors.black),
                          hintStyle: TextStyle(color: Colors.black)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your City';
                        }
                        String usernameRegex = r'^[a-zA-Z]';
                        RegExp usernameRegExp = RegExp(usernameRegex);
                        if (!usernameRegExp.hasMatch(value)) {
                          return 'Please Enter valid Name.';
                        }
                        if (value.length < 3) {
                          return 'Username must be at least 3 characters';
                        }
                        if (value.length > 50) {
                          return 'Username cannot be more than 50 characters';
                        }

                        return null; // Return null if the input is valid
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text("Select Your Blood Group:",
                      style: GoogleFonts.inter(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: DropdownButton<String>(
                      value: _selectedBloodGroup, // Set the selected value here
                      items: <String>[
                        'A+',
                        'A-',
                        'B+',
                        'B-',
                        'AB+',
                        'AB-',
                        'O+',
                        'O-',
                        "NI"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedBloodGroup =
                              newValue!; // Update the selected value
                        });
                        print('User selected $_selectedBloodGroup');
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Searching')));
                      Get.to(() => DonorForm());
                    } else {
                      // Authentication failed, display an error message to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Faild to Search')));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: tWhiteColor,
                    backgroundColor: Colors.red,
                  ),
                  child: Text(tDonorSearch.toUpperCase()),
                ),
              ),
            ]),
          ),
        ));
  }
}
