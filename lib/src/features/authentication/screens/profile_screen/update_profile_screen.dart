// ignore_for_file: unused_local_variable, library_private_types_in_public_api, prefer_const_constructors, unused_field, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

// ... (imports and other code above)

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool isDarkMode = false;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    var iconColor = isDarkMode ? Colors.white : apptextColor;
    Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    Color textColor = isDarkMode ? Colors.white : Colors.black;
    Color buttonColor = isDarkMode ? Colors.blue : Colors.blue;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(LineAwesomeIcons.angle_left, color: tWhiteColor),
        ),
        title: Center(
          child: Text(
            tEditProfileB,
            style: GoogleFonts.montserrat(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(image: AssetImage(tProfileI)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onDoubleTap: () {},
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: buttonColor,
                        ),
                        child: const Icon(
                          LineAwesomeIcons.camera,
                          size: 22.0,
                          color: tWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_outlined),
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        hintText: 'Enter your username',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Username.';
                        }
                        if (value.length < 6) {
                          return 'Username should contain atleast 8 letters';
                        }
// Regular expression for validating a Username (alphanumeric characters only)
                        String usernameRegex = r'^[a-zA-Z0-9]';
                        RegExp usernameRegExp = RegExp(usernameRegex);

                        if (!usernameRegExp.hasMatch(value)) {
                          return 'Enter a valid email address or username.';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter your email',
                      ),
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

                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        labelText: 'Phone Number',
                        hintText: 'Enter your phone number',
                      ),
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
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      validator: (value) {
                        //Check is password is filled
                        if (value!.isEmpty) {
                          return 'Please Enter your password.';
                        }
                        //Check Password Length
                        if (value.length < 8) {
                          return 'Please Must be at least 8 Characters';
                        }
                        //Check Password has uppercase letter
                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'Password must have at least one Uppercase letter';
                        }
                        //Check Password has Lowercase letter
                        if (!value.contains(RegExp(r'[a-z]'))) {
                          return 'Password must have at least one Lowercase letter ';
                        }
                        //Check Password has Special Character
                        if (!value
                            .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          return 'Password must have at leat one Special Character';
                        }
                        //Check Password has numbers
                        if (!value.contains(RegExp(r'[0-9]'))) {
                          return 'Password must have at least one number';
                        }
                        return null; // Return null if the input is valid
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        hintText: 'Re-enter your password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                          icon: Icon(_isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      validator: (value) {
                        //Check is password is filled
                        if (value!.isEmpty) {
                          return 'Please Enter your password.';
                        }
                        //Check Password Length
                        if (value.length < 8) {
                          return 'Please Must be at least 8 Characters';
                        }
                        //Check Password has uppercase letter
                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'Password must have at least one Uppercase letter';
                        }
                        //Check Password has Lowercase letter
                        if (!value.contains(RegExp(r'[a-z]'))) {
                          return 'Password must have at least one Lowercase letter ';
                        }
                        //Check Password has Special Character
                        if (!value
                            .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          return 'Password must have at leat one Special Character';
                        }
                        //Check Password has numbers
                        if (!value.contains(RegExp(r'[0-9]'))) {
                          return 'Password must have at least one number';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match.';
                        }
                        return null; // Return null if the input is valid
                      },
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Perform signup logic here
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('')),
                            );
                          } else {
                            // Display an error message to the user
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Authentication Failed')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Save Changes'.toUpperCase(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
