// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar2.dart';

class ClinicRegistration extends StatefulWidget {
  const ClinicRegistration({super.key});

  @override
  State<ClinicRegistration> createState() => _ClinicRegistrationState();
}

class _ClinicRegistrationState extends State<ClinicRegistration> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController clinicAddressController = TextEditingController();
  final TextEditingController clinicNameController = TextEditingController();
  List<TextEditingController> doctorNameController = [TextEditingController()];
  final TextEditingController numberOfRoomsController = TextEditingController();
  final TextEditingController numberOfDoctorsController =
      TextEditingController();
  List<TextEditingController> licenseNumberController = [
    TextEditingController()
  ];
  List<TextEditingController> facilitiesController = [TextEditingController()];

  void _handleMenuPressed() {
    scaffoldKey.currentState?.openDrawer();
  }

  void addDoctorField() {
    setState(() {
      doctorNameController.add(TextEditingController());
    });
  }

  void addFacility() {
    setState(() {
      facilitiesController.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      drawer: ReusableDrawerSideBar2(
          color: Colors.tealAccent.shade400, headerText: "Clinic Registration"),
      appBar: Navbar(
          color: Colors.tealAccent.shade400,
          textNav: "Clinic Registration",
          onMenuPressed: _handleMenuPressed),
      body: Padding(
        padding: EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(children: [
                Text(
                  "Register Your Clinic",
                  style: GoogleFonts.montserrat(
                      color: Colors.tealAccent.shade400,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 22,
                ),
                //Clinic Name
                TextFormField(
                    controller: clinicNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.hospital),
                      border: OutlineInputBorder(),
                      labelText: 'Clinic Name',
                      hintText: 'Enter Clinic Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Clinic Name.';
                      }
                      return null;
                    }),
                //Clinic Email
                SizedBox(
                  height: 15.0,
                ),
                //Email
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter Clinic Email Address',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Clinic Email Address.';
                    }

                    // Regular expression for validating an Email
                    // You can use a more comprehensive regex for stricter validation
                    String emailRegex =
                        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                    RegExp emailRegExp = RegExp(emailRegex);
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Enter a valid Email Address';
                    }

                    return null; // Return null if the input is valid
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                //Pnone Number
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                    labelText: 'Clinic Contact Number',
                    hintText: 'Enter Clinic Contact Number',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Clinic Contact Number';
                    } else if (value.startsWith('+92') && value.length != 13) {
                      return 'Invalid phone number. Pakistani numbers starting with +92 must have 13 digits.';
                    } else if (!value.startsWith('03') && value.length != 11) {
                      return 'Invalid phone number. Pakistani mobile numbers must start with 03 and have 11 digits.';
                    }
                    return null; // Validation passed
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                //Address Controller
                TextFormField(
                    controller: clinicNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.map),
                      border: OutlineInputBorder(),
                      labelText: 'Clinic Address',
                      hintText: 'Enter Clinic Address',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Clinic Address.';
                      }
                      return null;
                    }),

                SizedBox(
                  height: 15.0,
                ),
                //Number of Doctors
                TextFormField(
                  controller: numberOfDoctorsController,
                  decoration: InputDecoration(
                      labelText: 'Number of Doctors',
                      hintText: 'Enter Number of Doctors',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(FontAwesomeIcons.userDoctor)),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 15,
                ),
                //Number of Rooms
                TextFormField(
                  controller: numberOfRoomsController,
                  decoration: InputDecoration(
                      labelText: 'Number of Rooms',
                      hintText: 'Enter Number of Rooms',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(FontAwesomeIcons.bedPulse)),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 15,
                ),
                //Name of Doctors
                for (int i = 0; i < doctorNameController.length; i++)
                  TextFormField(
                    controller: doctorNameController[i],
                    decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.userDoctor),
                      border: OutlineInputBorder(),
                      labelText: 'Doctor Name',
                      hintText: 'Enter Doctor Name',
                      suffixIcon: i == doctorNameController.length - 1
                          ? IconButton(
                              icon: Icon(Icons.add),
                              onPressed: addDoctorField,
                            )
                          : null,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Doctor Name.';
                      }
                      return null;
                    },
                  ),
                SizedBox(
                  height: 15,
                ),
                //Licence Number
                for (int i = 0; i < licenseNumberController.length; i++)
                  TextFormField(
                    controller: licenseNumberController[i],
                    decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.idCard),
                      border: OutlineInputBorder(),
                      labelText: 'Licence Number',
                      hintText: 'Enter Licence Number',
                      suffixIcon: i == licenseNumberController.length - 1
                          ? IconButton(
                              icon: Icon(Icons.add),
                              onPressed: addDoctorField,
                            )
                          : null,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Doctor Name.';
                      }
                      return null;
                    },
                  ),
                SizedBox(
                  height: 15,
                ),
                //Facilities
                for (int i = 0; i < facilitiesController.length; i++)
                  TextFormField(
                    controller: facilitiesController[i],
                    decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.medkit),
                      border: OutlineInputBorder(),
                      labelText: 'Facilites',
                      hintText: 'Enter Facilities in Your Clinic',
                      suffixIcon: i == facilitiesController.length - 1
                          ? IconButton(
                              icon: Icon(Icons.add),
                              onPressed: addDoctorField,
                            )
                          : null,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Doctor Name.';
                      }
                      return null;
                    },
                  ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        List<String> doctorNames = doctorNameController
                            .map((controller) => controller.text)
                            .toList();
                        List<String> facilities = facilitiesController
                            .map((controller) => controller.text)
                            .toList();
                        List<String> licence = licenseNumberController
                            .map((controller) => controller.text)
                            .toList();
                        final name = clinicNameController.text.trim();
                        final contact = phoneController.text.trim();
                        final address = clinicAddressController.text.trim();
                        final numberRooms = numberOfRoomsController.text.trim();
                        final numberDoctor =
                            numberOfDoctorsController.text.trim();
                        final email = emailController.text.trim();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ]),
            )),
      ),
    ));
  }
}
