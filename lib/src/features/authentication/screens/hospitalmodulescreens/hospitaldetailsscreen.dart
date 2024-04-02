// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar2.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalPage1 extends StatefulWidget {
  const HospitalPage1({Key? key}) : super(key: key);

  @override
  _HospitalPage1State createState() => _HospitalPage1State();
}
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

void _handleMenuPressed() {
  scaffoldKey.currentState?.openDrawer();
}
class _HospitalPage1State extends State<HospitalPage1> {
  List<String> facilitiesList = [];
  List<String> servicesList = [];
  List<String> departmentsList = [];

  @override
  void initState() {
    super.initState();
    _fetchFilterOptions();
  }

  void _fetchFilterOptions() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('HospitalData').get();
    Set<String> facilities = Set();
    Set<String> services = Set();
    Set<String> departments = Set();

    snapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>;
      facilities.addAll((data['facilities'] ?? [])?.cast<String>() ?? []);
      services.addAll((data['services'] ?? [])?.cast<String>() ?? []);
      departments.addAll((data['departments'] ?? [])?.cast<String>() ?? []);
    });

    setState(() {
      facilitiesList = facilities.toList();
      servicesList = services.toList();
      departmentsList = departments.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Find Your Perfect Care',
          style: TextStyle(color: Colors.white, fontSize: 22.0),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10.0),
                  _buildExpansionTile(
                      'Facilities', facilitiesList, Icons.business),
                  const SizedBox(height: 10.0),
                  _buildExpansionTile(
                      'Services', servicesList, Icons.medical_services),
                  const SizedBox(height: 10.0),
                  _buildExpansionTile('Departments', departmentsList,
                      Icons.local_hospital),
                ],
              ),
            ),
          ),
          Expanded(
            child: _buildHospitalList(),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile(
      String label, List<String> options, IconData icon) {
    return Card(
      elevation: 2,
      child: ExpansionTile(
        title: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        children: options.map((option) {
          return ListTile(
            title: Text(option),
            onTap: () {
              // Handle option selection
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHospitalList() {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('HospitalData').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        List<Widget> hospitalsWidgets = [];
        final hospitals = snapshot.data!.docs;
        for (var hospital in hospitals) {
          final data = hospital.data() as Map<String, dynamic>;
          if (data.containsKey('hospitalName') && data.containsKey('city')) {
            hospitalsWidgets.add(
              HospitalCard(
                hospitalName: data['hospitalName'],
                city: data['city'],
                province: data['province'],
                zipCode: data['zipCode'],
                docId: hospital.id,
              ),
            );
          }
        }

        return ListView(
          children: hospitalsWidgets,
        );
      },
    );
  }
}

class HospitalCard extends StatelessWidget {
  final String hospitalName;
  final String city;
  final String province;
  final String zipCode;
  final String docId;

  const HospitalCard({
    required this.hospitalName,
    required this.city,
    required this.province,
    required this.zipCode,
    required this.docId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      elevation: 5,
      child: ListTile(
        leading: Hero(
          tag: docId,
          child: CircleAvatar(
            child: Text(hospitalName[0]),
          ),
        ),
        title: Text(hospitalName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLocationInfoRow(
              icon: Icons.location_on,
              text: city,
              color: Colors.blue.shade600,
            ),
            _buildLocationInfoRow(
              icon: Icons.location_city,
              text: province,
              color: Colors.blue.shade600,
            ),
            _buildLocationInfoRow(
              icon: Icons.location_city,
              text: zipCode,
              color: Colors.blue.shade600,
            ),
          ],
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Get.to(()=>(HospitalDetailScreen(docId: docId)));
        },
      ),
    );
  }

  Widget _buildLocationInfoRow(
      {required IconData icon,
      required String text,
      required Color color,
      Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 5),
            Text(
              text,
              style: const TextStyle(color: Color.fromARGB(255, 25, 118, 210)),
            ),
          ],
        ),
      ),
    );
  }
}

class HospitalDetailScreen extends StatelessWidget {
  final String docId;

  const HospitalDetailScreen({Key? key, required this.docId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: scaffoldKey,
      drawer: ReusableDrawerSideBar2(color: Colors.blueAccent, headerText: "Hospitals"),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Find Your Perfect Care", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      
      ),),
        body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('HospitalData').doc(docId).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data?.data() == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final hospitalData = snapshot.data!.data()! as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hospitalData['hospitalName'] ?? 'No Name Available',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 13, 71, 161),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  hospitalData['additionalInfo'] ?? 'No additional information provided',
                  style: const TextStyle(color: Color.fromARGB(255, 25, 118, 210)),
                ),

                const SizedBox(height: 10.0),
               _buildBasicInfoSection(hospitalData),
                _buildOtherFieldsCard(hospitalData),
              ],
            ),
          );
        },
      ),
    );
  }
Widget _buildBasicInfoRow({
  IconData? icon,
  required String label,
  required String text,
  required Color color,
  Function()? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: color),
            const SizedBox(width: 10.0),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Color.fromARGB(255, 25, 118, 210),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildBasicInfoSection(Map<String, dynamic> hospitalData) {
  return Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Icon(Icons.info),
           Text(
            'Basic Information',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          ],),
          
          const SizedBox(height: 10.0),
           _buildBasicInfoRow(
            icon: Icons.location_city,
            label: 'Sector:',
            text: ' ${hospitalData['sector'] ?? 'No data available'}',
            color: Colors.blue.shade600,
          ),
          _buildBasicInfoRow(
            icon: Icons.map_outlined,
            label: 'Address:',
            text: hospitalData['address'] ?? 'No address provided',
            color: Colors.blue.shade600,
            onTap: () async {
              final url = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(hospitalData['address'] ?? '')}';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        
          _buildBasicInfoRow(
            icon: Icons.phone,
            label: 'Contact Number:',
            text: hospitalData['contactNumber'] ?? 'No contact number provided',
            color: Colors.blue.shade600,
            onTap: () async {
              final url = 'tel:${hospitalData['contactNumber']}';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          _buildBasicInfoRow(
            icon: Icons.email,
            label: 'Email Address:',
            text: hospitalData['email'] ?? 'No email address provided',
            color: Colors.blue.shade600,
            onTap: () async {
              final url = 'mailto:${hospitalData['email']}';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
              _buildBasicInfoRow(
            icon: Icons.location_on,
            label: 'Provice:',
            text: ' ${hospitalData['province'] ?? 'No data available'}',
            color: Colors.blue.shade600,
          ),
            _buildBasicInfoRow(
            icon: Icons.location_city,
            label: 'City:',
            text: ' ${hospitalData['city'] ?? 'No data available'}',
            color: Colors.blue.shade600,
          ),
            _buildBasicInfoRow(
            icon: Icons.code_outlined,
            label: 'Zip Code:',
            text: ' ${hospitalData['zipCode'] ?? 'No data available'} ',
            color: Colors.blue.shade600,
          ),
          _buildBasicInfoRow(
            icon: Icons.personal_injury_outlined,
            label: 'Number of Departments:',
            text: ' ${hospitalData['numberOfDepartments'] ?? 'No data available'}',
            color: Colors.blue.shade600,
          ),
          _buildBasicInfoRow(
            icon: Icons.wheelchair_pickup,
            label: 'Number of Wards:',
            text: ' ${hospitalData['wards'] ?? 'No data available'}',
            color: Colors.blue.shade600,
          ),
          _buildBasicInfoRow(
            icon: Icons.money,
            label: 'Zakat Accepted:',
            text: ' ${hospitalData['zakat'] ?? 'No data available'}',
            color: Colors.blue.shade600,
          ),
          _buildBasicInfoRow(
            icon: Icons.monetization_on,
            label: 'Insurance Accepted:',
            text: ' ${hospitalData['insuranceAccepted'] ?? 'No data available'}',
            color: Colors.blue.shade600,
          ),
          _buildBasicInfoRow(
            icon: Icons.layers,
            label: 'Number of Departments:',
            text: ' ${hospitalData['numberOfDepartments'] ?? 'No data available'}',
            color: Colors.blue.shade600,
          ),
        ],
      ),
    ),
  );
}

  Widget _buildOtherFieldsCard(Map<String, dynamic> hospitalData) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExpansionCard(
              title: 'Visiting Hours',
              data: hospitalData['visitingHours'] ?? [],
              icon: Icons.access_time,
            ),
            const SizedBox(height: 10),
            _buildExpansionCard(
              title: 'Services',
              data: hospitalData['services'] ?? [],
              icon: Icons.medical_services,
            ),
            const SizedBox(height: 10),
            _buildExpansionCard(
              title: 'Facilities',
              data: hospitalData['facilities'] ?? [],
              icon: Icons.business,
            ),
            const SizedBox(height: 10),
            _buildExpansionCard(
              title: 'Departments',
              data: hospitalData['departments'] ?? [],
              icon: Icons.local_hospital,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionCard({required String title, required List<dynamic> data, required IconData icon}) {
    return Card(
      elevation: 2,
      child: ExpansionTile(
        title: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        children: data.map<Widget>((item) {
          if (item is Map<String, dynamic>) {
            String startTime = item['start'] ?? '';
            String endTime = item['end'] ?? '';
            return _buildInfoRow(null, '$startTime - $endTime', Colors.blue.shade600);
          }
          return _buildInfoRow(null, item.toString(), Colors.blue.shade600);
        }).toList(),
      ),
    );
  }

  Widget _buildInfoRow(IconData? icon, String text, Color color) {
    return InkWell(
      onTap: null, // Define onTap behavior as needed
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: color),
              const SizedBox(width: 10.0),
            ],
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 25, 118, 210)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
