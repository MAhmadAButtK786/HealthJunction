// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorDetailScreen extends StatefulWidget {
  final String docId;

  const DoctorDetailScreen({Key? key, required this.docId}) : super(key: key);

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  late Future<DocumentSnapshot> _doctorSnapshot;

  @override
  void initState() {
    super.initState();
    _doctorSnapshot = FirebaseFirestore.instance
        .collection('doctors')
        .doc(widget.docId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor Appointment',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _doctorSnapshot,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return const Center(child: Text('Doctor data not found'));
          }

          final doctorData = snapshot.data!.data() as Map<String, dynamic>;

          final String fullName = doctorData['fullName'] ?? '';
          final String initials =
              fullName.isNotEmpty ? fullName[0].toUpperCase() : 'Dr';
          final String gender = doctorData['gender'] ?? '';
          final String address = doctorData['address'] ?? '';
          final String email = doctorData['email'] ?? '';
          final String city = doctorData['city'] ?? '';
          final String phoneNumber = doctorData['phoneNumber'] ?? '';
          final double pricePerVisit =
              doctorData['pricePerVisit']?.toDouble() ?? 0.0;
          final String profilePicture = doctorData['profilePicture'] ?? '';
          final String province = doctorData['province'] ?? '';
          final String specialty = doctorData['specialty'] ?? '';
          final String workingHours = doctorData['workingHours'] ?? '';
          final List<dynamic>? availableDays =
              doctorData['availableDays'] as List<dynamic>?;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: profilePicture.isNotEmpty
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(profilePicture),
                          radius: 70.0, // Larger profile picture
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.teal[700],
                          radius: 70.0,
                          child: Text(
                            initials,
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 40.0, // Larger initials
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: doctorData['email'],
                          );
                          String uri = emailLaunchUri.toString();
                          if (await canLaunch(uri)) {
                            await launch(uri);
                          } else {
                            throw 'Could not launch $uri';
                          }
                        },
                        icon: const Icon(Icons.email, color: Colors.teal, size: 35),
                      ),
                      IconButton(
                        onPressed: () async {
                          final url = 'tel:${doctorData['phoneNumber']}';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        icon: const Icon(Icons.phone, color: Colors.teal, size: 35),
                      ),
                      IconButton(
                        onPressed: () async {
                          final url =
                              'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(doctorData['address'] ?? '')}';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        icon: const Icon(Icons.map, color: Colors.teal, size: 35),
                      ),
                      IconButton(
                        onPressed: () async {
                          final url = 'sms:$phoneNumber';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        icon: const Icon(Icons.message_outlined, color: Colors.teal, size: 35),
                      ),
                      IconButton(
                        onPressed: () async {
                          final url = 'https://wa.me/$phoneNumber';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        icon: const Icon(FontAwesomeIcons.whatsapp, color: Colors.teal, size: 35),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                _buildDetailItem(
                  'Full Name',
                  fullName,
                  FontAwesomeIcons.userDoctor,
                  color: const Color.fromARGB(255, 0, 121, 107),
                ),
                _buildDetailItem(
                  'Specialty',
                  specialty,
                  Icons.medical_services,
                  color: const Color.fromARGB(255, 0, 121, 107),
                ),
                _buildDetailItem(
                  'Gender',
                  gender,
                  Icons.people,
                  color: const Color.fromARGB(255, 0, 121, 107),
                ),
                _buildDetailItem(
                  'Province',
                  province,
                  Icons.location_city,
                  color: const Color.fromARGB(255, 0, 121, 107),
                ),
                _buildDetailItem(
                  'City',
                  city,
                  Icons.location_city_sharp,
                  color: const Color.fromARGB(255, 0, 121, 107),
                ),
                _buildDetailItem(
                  'Address',
                  address,
                  Icons.location_pin,
                  color: const Color.fromARGB(255, 0, 121, 107),
                ),
                _buildDetailItem(
                  'Email',
                  email,
                  Icons.mail,
                  color: const Color.fromARGB(255, 0, 121, 107),
                ),
                _buildDetailItem(
                  'Phone Number',
                  phoneNumber,
                  Icons.phone,
                  color: const Color.fromARGB(255, 0, 121, 107),
                ),
                _buildDetailItem(
                  'Working Hours',
                  workingHours,
                  Icons.access_time,
                  color: const Color.fromARGB(255, 0, 121, 107),
                ),
                _buildDetailItem(
                  'Price Per Visit',
                  'PKR ${pricePerVisit.toStringAsFixed(2)}',
                  Icons.money,
                  color: const Color.fromARGB(255, 0, 121, 107),
                ),
               const SizedBox(height: 3,),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_sharp,color: Color.fromARGB(255, 0, 121, 107),),
                    Text("Available Days", style: GoogleFonts.montserrat(fontWeight:FontWeight.bold,fontSize:16),),
                  ],
                ),
                const SizedBox(height: 4,),
                _buildAvailabilityGrid(availableDays),
                const SizedBox(height: 20.0),
                ElevatedButton.icon(
                  onPressed: () {
                  },
                  icon: const Icon(Icons.book, color: Colors.white,),
                  label: Text(
                    'Book Appointment',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[700],
                    minimumSize: const Size(double.infinity, 50.0), // Full-width button
                  ),
                ),
                const SizedBox(height: 20.0), // Add spacing after last item
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon,
      {Color color = Colors.teal}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: color,
          size: 24.0,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800], // Darker text for better contrast
                ),
              ),
              Text(
                value,
                style: GoogleFonts.lato(
                  fontSize: 19.0,
                  color: Colors.grey[600], // Lighter text for details
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvailabilityGrid(List<dynamic>? availableDays) {
    if (availableDays == null || availableDays.isEmpty) {
      return const SizedBox.shrink();
    }

    final daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final availability = List.generate(7, (index) => availableDays[index] ?? false);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemCount: daysOfWeek.length,
      itemBuilder: (context, index) {
        final day = daysOfWeek[index];
        final isAvailable = availability[index];
        return Container(
          decoration: BoxDecoration(
            color: isAvailable ? Colors.green[200] : Colors.red[200],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              day.substring(0, 3),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isAvailable ? Colors.green[800] : Colors.red[800],
              ),
            ),
          ),
        );
      },
    );
  }
}
