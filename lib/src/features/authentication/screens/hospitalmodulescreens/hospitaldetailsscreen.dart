import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalPage1 extends StatefulWidget {
  const HospitalPage1({Key? key}) : super(key: key);

  @override
  _HospitalPage1State createState() => _HospitalPage1State();
}

class _HospitalPage1State extends State<HospitalPage1> {
  late TextEditingController _searchController;
  late String searchTerm = '';
  List<String> facilitiesList = [];
  List<String> servicesList = [];
  List<String> departmentsList = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _fetchFilterOptions();
  }

  void _fetchFilterOptions() async {
    final snapshot = await FirebaseFirestore.instance.collection('HospitalData').get();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Hospitals by Name or City',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (value) => _performSearch(),
                ),
                const SizedBox(height: 10.0),
                _buildExpansionTile('Facilities', facilitiesList, Icons.business),
                const SizedBox(height: 10.0),
                _buildExpansionTile('Services', servicesList, Icons.medical_services),
                const SizedBox(height: 10.0),
                _buildExpansionTile('Departments', departmentsList, Icons.local_hospital),
              ],
            ),
          ),
          Expanded(
            child: _buildHospitalList(),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile(String label, List<String> options, IconData icon) {
    return ExpansionTile(
      title: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
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
    );
  }

  void _performSearch() {
    setState(() {
      searchTerm = _searchController.text.toLowerCase().trim();
    });
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
            if (_shouldShowHospital(data)) {
              hospitalsWidgets.add(
                HospitalCard(
                  hospitalName: data['hospitalName'],
                  city: data['city'],
                  docId: hospital.id,
                ),
              );
            }
          }
        }

        return ListView(
          children: hospitalsWidgets,
        );
      },
    );
  }

  bool _shouldShowHospital(Map<String, dynamic> hospitalData) {
    if (searchTerm.isNotEmpty) {
      if (!(hospitalData['hospitalName'].toString().toLowerCase().contains(searchTerm) ||
          hospitalData['city'].toString().toLowerCase().contains(searchTerm))) {
        return false;
      }
    }
    // Apply other filters here
    return true;
  }
}

class HospitalCard extends StatelessWidget {
  final String hospitalName;
  final String city;
  final String docId;

  const HospitalCard({
    required this.hospitalName,
    required this.city,
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
        subtitle: Text(city),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HospitalDetailScreen(docId: docId),
            ),
          );
        },
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
      appBar: AppBar(
        title: const Text('Hospital Details'),
        backgroundColor: Colors.blue.shade800,
      ),
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
                const SizedBox(height: 20.0),
                _buildInfoRow(
                  Icons.location_on,
                  '${hospitalData['address'] ?? ''}, ${hospitalData['city'] ?? ''}, ${hospitalData['province'] ?? ''} - ${hospitalData['zipCode'] ?? ''}',
                  Colors.blue.shade600,
                  onTap: () async {
                    final url = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(hospitalData['address'] ?? '')}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                _buildInfoRow(
                  Icons.phone,
                  hospitalData['contactNumber'] ?? 'No contact number provided',
                  Colors.blue.shade600,
                  onTap: () async {
                    final url = 'tel:${hospitalData['contactNumber']}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                _buildInfoRow(
                  Icons.email,
                  hospitalData['email'] ?? 'No email address provided',
                  Colors.blue.shade600,
                  onTap: () async {
                    final url = 'mailto:${hospitalData['email']}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                _buildSection('Departments', hospitalData['departments'] ?? [], Icons.local_hospital),
                _buildSection('Facilities', hospitalData['facilities'] ?? [], Icons.business),
                _buildSection('Services', hospitalData['services'] ?? [], Icons.medical_services),
                _buildSection('Visiting Hours', hospitalData['visitingHours'] ?? [], Icons.access_time),
                _buildInfoRow(
                  Icons.wheelchair_pickup,
                  'Number of Wards: ${hospitalData['wards'] ?? 'No data available'}',
                  Colors.blue.shade600,
                ),
                _buildInfoRow(
                  Icons.money,
                  'Zakat Accepted: ${hospitalData['zakat'] ?? 'No data available'}',
                  Colors.blue.shade600,
                ),
                _buildInfoRow(
                  Icons.monetization_on,
                  'Insurance Accepted: ${hospitalData['insuranceAccepted'] ?? 'No data available'}',
                  Colors.blue.shade600,
                ),
                _buildInfoRow(
                  Icons.layers,
                  'Number of Departments: ${hospitalData['numberOfDepartments'] ?? 'No data available'}',
                  Colors.blue.shade600,
                ),
                _buildInfoRow(
                  Icons.location_city,
                  'Sector: ${hospitalData['sector'] ?? 'No data available'}',
                  Colors.blue.shade600,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData? icon, String text, Color? color, {Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
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

  Widget _buildSection(String title, List<dynamic> data, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 1.0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(icon, color: Colors.blue),
              SizedBox(width: 10.0),
              Text(
                title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 13, 71, 161)),
              ),
            ],
          ),
        ),
        ...data.map<Widget>((item) {
          if (item is Map<String, dynamic>) {
            String startTime = item['start'] ?? '';
            String endTime = item['end'] ?? '';
            return _buildInfoRow(null, '$startTime - $endTime', Colors.blue.shade600);
          }
          return _buildInfoRow(null, item.toString(), Colors.blue.shade600);
        }).toList(),
      ],
    );
  }
}
