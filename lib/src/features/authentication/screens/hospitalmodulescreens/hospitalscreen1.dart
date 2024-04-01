import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/features/authentication/screens/hospitalmodulescreens/hospitaldetailsscreen.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar2.dart';
class HospitalPage1 extends StatefulWidget {
  const HospitalPage1({Key? key}) : super(key: key);

  @override
  _HospitalPage1State createState() => _HospitalPage1State();
}

class _HospitalPage1State extends State<HospitalPage1> {
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
      drawer: ReusableDrawerSideBar2(
        headerText: "Hospitals",
        color: Colors.blue,
      ),
      appBar: AppBar(
        title: const Text(
          'Find Your Perfect Care ',
          style: TextStyle(color: Colors.white, fontSize: 22.0),
        ),
        backgroundColor: Colors.blue,
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
                hintText: 'Search Hospitals by Name or City',
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
              stream: FirebaseFirestore.instance.collection('HospitalData').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<Widget> hospitalsWidgets = [];
                final hospitals = snapshot.data!.docs;
                for (var hospital in hospitals) {
                  final data = hospital.data() as Map<String, dynamic>;
                  if (data.containsKey('hospitalName') && data.containsKey('city')) {
                    if (searchTerm.isEmpty ||
                        data['hospitalName'].toString().toLowerCase().contains(searchTerm) ||
                        data['city'].toString().toLowerCase().contains(searchTerm)) {
                      hospitalsWidgets.add(
                        HospitalCard(
                          hospitalName: data['hospitalName'],
                          city: data['city'],
                          docId: hospital.id, // Access the document ID here
                          onTap: () => Get.to(
                            () => HospitalDetailScreen(docId: hospital.id),
                          ),
                        ),
                      );
                    }
                  }
                }

                return ListView.builder(
                  itemCount: hospitalsWidgets.length,
                  itemBuilder: (context, index) => hospitalsWidgets[index],
                );
              },
            ),
          ),
        ],
      ),
    );
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
    Key? key, required Future? Function() onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
                leading: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.indigo,
              child: Text(
                hospitalName[0].toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 10.0,
                width: 10.0,
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  color: Colors.green, // Green "healthy" indicator
                ),
              ),
            ), // Green dot indicator
          ],
        ),
        title: Text(
          hospitalName,
          style: const TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Colors.white,
              size: 18.0,
            ),
            const SizedBox(width: 5.0),
            Text(
              city,
              style: const TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right,
          color: Colors.white,
          size: 30.0,
        ),
        onTap: () => Get.to(
          () => HospitalDetailScreen(docId: docId),
        ),
      ),
    );
  }
}

