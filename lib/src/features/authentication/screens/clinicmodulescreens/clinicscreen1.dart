import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/features/authentication/screens/clinicmodulescreens/doctordetails.dart';

class DoctorPage1 extends StatefulWidget {
  const DoctorPage1({Key? key}) : super(key: key);

  @override
  _DoctorPage1State createState() => _DoctorPage1State();
}

class _DoctorPage1State extends State<DoctorPage1> {
  late TextEditingController _searchController;
  late String searchTerm = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  void _performSearch() {
    setState(() {
      searchTerm = _searchController.text.toLowerCase().trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Find Your Perfect Doctor',
          style: TextStyle(color: Colors.white, fontSize: 22.0),
        ),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: _performSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Doctor by Name, Specialty, City, etc.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchTerm.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => setState(() => searchTerm = ''),
                      )
                    : null,
              ),
              onChanged: (value) => _performSearch(),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<Widget> doctorsWidgets = [];
                final doctors = snapshot.data!.docs;
                for (var doctor in doctors) {
                  final data = doctor.data() as Map<String, dynamic>;
                  if (data.containsKey('fullName') &&
                      data.containsKey('specialty') &&
                      data.containsKey('city')) {
                    if (searchTerm.isEmpty ||
                        data['fullName']
                            .toString()
                            .toLowerCase()
                            .contains(searchTerm) ||
                        data['specialty']
                            .toString()
                            .toLowerCase()
                            .contains(searchTerm) ||
                        data['city'].toString().toLowerCase().contains(searchTerm)) {
                      doctorsWidgets.add(
                        DoctorCard(
                          fullName: data['fullName'],
                          specialty: data['specialty'],
                          city: data['city'],
                          profilePicture: data['profilePicture'],
                          onTap: () => Get.to(
                            () => DoctorDetailScreen(docId: doctor.id),
                          ),
                        ),
                      );
                    }
                  }
                }

                return ListView.builder(
                  itemCount: doctorsWidgets.length,
                  itemBuilder: (context, index) => doctorsWidgets[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String fullName;
  final String specialty;
  final String city;
  final String? profilePicture;
  final VoidCallback onTap; // Change this to VoidCallback

  const DoctorCard({
    required this.fullName,
    required this.specialty,
    required this.city,
    required this.profilePicture,
    Key? key,
    required this.onTap, // Update the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.lightBlue,
          child: profilePicture != null
              ? ClipOval(
                  child: Image.network(
                    profilePicture!,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                )
              : Text(
                  fullName[0].toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 18.0),
                ),
        ),
        title: Text(
          fullName,
          style: const TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Adjust alignment
          children: [
            Row(
              children: [
                const Icon(Icons.local_hospital_outlined, color: Colors.white),
                const SizedBox(width: 5), // Add some spacing
                Expanded(
                  child: Text(
                    specialty,
                    style: const TextStyle(color: Colors.white, fontSize: 16.0),
                    overflow: TextOverflow.ellipsis, // Add ellipsis for long texts
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.map_rounded, color: Colors.white),
                const SizedBox(width: 5), // Add some spacing
                Text(
                  city,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right,
          color: Colors.white,
          size: 30.0,
        ),
        onTap: onTap, // Correctly pass onTap function
      ),
    );
  }
}

