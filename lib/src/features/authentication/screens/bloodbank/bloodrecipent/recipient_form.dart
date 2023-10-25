// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, unused_local_variable, avoid_init_to_null, prefer_final_fields, avoid_print, unnecessary_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_screen/profile_screen.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class RecipientForm extends StatefulWidget {
  const RecipientForm({super.key});

  @override
  State<RecipientForm> createState() => _RecipientForm();
}

enum Gender { male, female, others }

class _RecipientForm extends State<RecipientForm> {
  final _formKey = GlobalKey<FormState>();
  bool isDarkMode = false;
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bloodTypeController = TextEditingController();
  final _ageController = TextEditingController();
  final _citynameController = TextEditingController();
  String _selectedBloodGroup = 'A+'; // Initial selected value
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Gender _site = Gender.male;
  void _handleMenuPressed() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    if (isDarkMode) {
      backgroundColor = Colors.red.shade200;
    } else {
      backgroundColor = Colors.red.shade200;
    }
    String? selectedGender = null;
    return Scaffold(
      key: scaffoldKey,
      appBar: Navbar(
        color: Colors.red,
        textNav: "Recipient Form",
        onMenuPressed: _handleMenuPressed,
      ),
      drawer: ReusableDrawerSideBar(
          color: Colors.red, headerText: "Recipient Form"),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: backgroundColor,
        padding: EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              tRegASRecipient,
              style: GoogleFonts.inter(
                  fontSize: 27, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Name Form
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_outline_outlined,
                          color: Colors.white,
                        ),
                        labelText: "Name",
                        hintText: "Enter Your Name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Name.';
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
                  SizedBox(
                    height: 10,
                  ),
                  //City
                  // Name Form
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
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
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
                  //Email Form
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.mail,
                          color: tWhiteColor,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email.';
                      }

                      // Regular expression for validating an Email
                      // You can use a more comprehensive regex for stricter validation
                      String emailRegex =
                          r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                      RegExp emailRegExp = RegExp(emailRegex);
                      if (!emailRegExp.hasMatch(value)) {
                        return 'Enter a valid email address or username.';
                      }

                      return null; // Return null if the input is valid
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  //Phone
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: tWhiteColor,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Phone Number',
                        hintText: 'Enter your phone number',
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Phone Number';
                      } else if (value.startsWith('+92') &&
                          value.length != 13) {
                        return 'Invalid phone number. Pakistani numbers starting with +92 must have 13 digits.';
                      } else if (!value.startsWith('03') ||
                          value.length != 11) {
                        return 'Invalid phone number. Pakistani mobile numbers must start with 03 and have 11 digits.';
                      }
                      return null; // Validation passed
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  //Age Form
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          LineAwesomeIcons.calendar_1,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Age',
                        hintText: 'Enter your Age',
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Age is required';
                      }
                      int? age = int.tryParse(value);
                      if (age == null || age < 18) {
                        return 'You must be at least 18 years old to donate blood';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //Gender Option
                  Text(
                    "Select Your Gender",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: RadioListTile(
                          title: const Text("Male"),
                          value: Gender.male,
                          groupValue: _site,
                          onChanged: (Gender? value) {
                            if (value != null) {
                              setState(() {
                                _site = value;
                              });
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: RadioListTile(
                          title: const Text('Female'),
                          value: Gender.female,
                          groupValue: _site,
                          onChanged: (Gender? value) {
                            if (value != null) {
                              setState(() {
                                _site = value;
                              });
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: RadioListTile(
                          title: const Text('Others'),
                          value: Gender.others,
                          groupValue: _site,
                          onChanged: (Gender? value) {
                            if (value != null) {
                              setState(() {
                                _site = value;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  //Blood Group
                  // Initial selected value
                  Row(
                    children: [
                      Text("Select Your Blood Group:",
                          style: GoogleFonts.inter(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: DropdownButton<String>(
                          value:
                              _selectedBloodGroup, // Set the selected value here
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
                          _showConfirmationDialog(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: tWhiteColor,
                        backgroundColor: Colors.red,
                      ),
                      child: Text(tRegASRecipient.toUpperCase()),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

Future<void> _showConfirmationDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Registration'),
        content: Text('Are you sure you want to register as a Recipient?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Confirm'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the confirmation dialog
              _showResultDialog(context); // Show registration result dialog
            },
          ),
        ],
      );
    },
  );
}

void _showResultDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Registration Result'),
        content: Text('You are registered as a Recipient!'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the result dialog
              // You can navigate to another screen if needed
            },
          ),
        ],
      );
    },
  );
}
