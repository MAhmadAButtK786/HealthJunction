// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/features/authentication/screens%20doctor%20module/hospitalRegistration/confirmationpage.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const Color primaryColor = Colors.tealAccent; // Deep Purple
const Color secondaryColor = Color(0xFFE0E0E0); // Light Gray

class DoctorRegistrationForm extends StatefulWidget {
  const DoctorRegistrationForm({Key? key}) : super(key: key);

  @override
  _DoctorRegistrationFormState createState() => _DoctorRegistrationFormState();
}

class _DoctorRegistrationFormState extends State<DoctorRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  File? _image;
  String? _downloadUrl;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _workingHoursController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? _gender;
  DateTime _dateOfBirth = DateTime.now();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  List<bool> _selectedDays = List.generate(7, (_) => false);
  final List<String> _daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  final List<String> _provinces = ['Punjab', 'Sindh', 'Khyber Pakhtunkhwa', 'Balochistan', 'Gilgit-Baltistan', 'Azad Kashmir','Islamabad Capital Territory'];
  String? _selectedProvince;

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      return;
    }

    final fileName = _image!.path.split('/').last;
    final reference = FirebaseStorage.instance.ref('doctorimages').child('doctor_profiles/$fileName');
    await reference.putFile(_image!);
    _downloadUrl = await reference.getDownloadURL();
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      await _uploadImage();
      final doctorData = {
        'fullName': _fullNameController.text,
        'email': _emailController.text,
        'phoneNumber': _phoneController.text,
        'licenseNumber': _licenseController.text,
        'specialty': _specialtyController.text,
        'bio': _bioController.text,
        'experience': int.parse(_experienceController.text),
        'workingHours': _workingHoursController.text,
        'availableDays': _selectedDays,
        'profilePicture': _downloadUrl,
        'gender': _gender,
        'dateOfBirth': _dateOfBirth.toIso8601String(),
        'address': _addressController.text,
        'city': _cityController.text,
        'province': _selectedProvince,
        'pricePerVisit': double.parse(_priceController.text),
      };

      await FirebaseFirestore.instance.collection('doctors').add(doctorData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Doctor registration successful!'),
          backgroundColor: Colors.green,
        ),
        
       
      );

      _formKey.currentState!.reset();
      _fullNameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _licenseController.clear();
      _specialtyController.clear();
      _bioController.clear();
      _experienceController.clear();
      _workingHoursController.clear();
      _addressController.clear();
      _cityController.clear();
      _priceController.clear();
      setState(() {
        _image = null;
        _downloadUrl = null;
        _startTime = null;
        _endTime = null;
        _selectedDays = List.generate(7, (_) => false);
        _gender = null;
        _dateOfBirth = DateTime.now();
        _selectedProvince = null;
      });
    }
     Get.to(() => const ConfirmationMessageScreen ());
  }

  String? _validateField(String? value) {
    if (value!.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    return DateFormat.Hm().format(DateTime(now.year, now.month, now.day, time.hour, time.minute));
  }

  void _selectGender(String gender) {
    setState(() {
      _gender = gender;
    });
  }

  void _selectDateOfBirth(DateTime date) {
    setState(() {
      _dateOfBirth = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Registration'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: secondaryColor,
                          border: Border.all(color: primaryColor, width: 2.0),
                          image: _image != null ? DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          ) : null,
                        ),
                      ),
                      if (_image == null)
                        const Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add_a_photo,
                              color: primaryColor,
                              size: 24.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                ),
                validator: _validateField,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateField,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: _validateField,
              ),
              const SizedBox(height: 10.0),
              const Text('Gender:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: _gender,
                        onChanged: (value) => _selectGender(value!),
                      ),
                      const Text('Male'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Female',
                        groupValue: _gender,
                        onChanged: (value) => _selectGender(value!),
                      ),
                      const Text('Female'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Other',
                        groupValue: _gender,
                        onChanged: (value) => _selectGender(value!),
                      ),
                      const Text('Other'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const Text('Date of Birth:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () async {
                  final DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _dateOfBirth,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    _selectDateOfBirth(selectedDate);
                  }
                },
                child: Text(
                  DateFormat('y MMMM d').format(_dateOfBirth),
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                value: _selectedProvince,
                decoration: InputDecoration(
                  labelText: 'Province',
                  prefixIcon: const Icon(Icons.location_city_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                ),
                items: _provinces.map((String province) {
                  return DropdownMenuItem<String>(
                    value: province,
                    child: Text(province),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedProvince = value;
                  });
                },
                validator: _validateField,
              ),
               const SizedBox(height: 10.0),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  prefixIcon: const Icon(Icons.location_city_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                ),
                validator: _validateField,
              ),
              
              const SizedBox(height: 10.0),
              
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  prefixIcon: const Icon(Icons.home),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                ),
                validator: _validateField,
              ),
             
              const SizedBox(height: 10.0,),
              TextFormField(
                controller: _licenseController,
                decoration: InputDecoration(
                  labelText: 'Medical License Number',
                  prefixIcon: const Icon(Icons.card_travel),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                ),
                keyboardType: TextInputType.text,
                validator: _validateField,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _specialtyController,
                decoration: InputDecoration(
                  labelText: 'Specialty',
                  prefixIcon: const Icon(Icons.medical_services),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                ),
                keyboardType: TextInputType.text,
                validator: _validateField,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _experienceController,
                decoration: InputDecoration(
                  labelText: 'Years of Experience',
                  prefixIcon: const Icon(Icons.work),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  try {
                    int.parse(value);
                    return null;
                  } catch (error) {
                    return 'Invalid number of years';
                  }
                },
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _workingHoursController,
                      decoration: InputDecoration(
                        labelText: 'Working Hours',
                        prefixIcon: const Icon(Icons.schedule),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: secondaryColor),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        _startTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (_startTime != null) {
                          _endTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (_endTime != null) {
                            setState(() {
                              _workingHoursController.text =
                                  '${formatTimeOfDay(_startTime!)} - ${formatTimeOfDay(_endTime!)}';
                            });
                          }
                        }
                      },
                      validator: _validateField,
                    ),
                  ),
                ],
              ),
            
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price per Visit (PKR)',
                  prefixIcon: const Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: _validateField,
              ),
              const SizedBox(height: 10.0),
              const Text('Available Days:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0),
              Wrap(
                spacing: 10.0,
                children: List.generate(
                  _daysOfWeek.length,
                  (index) => FilterChip(
                    label: Text(_daysOfWeek[index]),
                    selected: _selectedDays[index],
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedDays[index] = selected;
                      });
                    },
                    selectedColor: primaryColor,
                    checkmarkColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10.0,),
              TextFormField(
                controller: _bioController,
                maxLines: null, // This makes the field behave like a textarea
                decoration: InputDecoration(
                  labelText: 'Bio (Optional)',
                  prefixIcon: const Icon(Icons.info),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: _saveForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: const Size(double.infinity, 40.0),
                ),
                child: const Text('Register',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
