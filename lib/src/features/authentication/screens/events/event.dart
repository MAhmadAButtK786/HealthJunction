// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';
import 'package:url_launcher/url_launcher.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

void _handleMenuPressed() {
  scaffoldKey.currentState?.openDrawer();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: ReusableDrawerSideBar(
          headerText: "Events",
          color: Colors.brown,
        ),
        appBar: const Navbar(
          color: Colors.brown,
          textNav: "Events",
          onMenuPressed: _handleMenuPressed,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Event').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.grey.shade200, width: 1.0),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        // Formulate the event details
                        String eventName = data['eventName'];
                        String eventDateTime = data['date'] +
                            ' ' +
                            data['time']; // Combine date and time

                        // Format the event start time for the calendar event URL
                        String formattedDateTime = DateTime.parse(eventDateTime)
                            .toUtc()
                            .toIso8601String();

                        // Create the calendar event URL
                        String calendarEventUrl =
                            'https://calendar.google.com/calendar/r/eventedit?text=$eventName&dates=$formattedDateTime';

                        // Launch the URL
                        launch(calendarEventUrl);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Hero(
                              tag: data['imageUrl'],
                              child: Image.network(
                                data['imageUrl'],
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.event,
                                        color: Colors
                                            .brown), // Icon for event name
                                    const SizedBox(width: 5),
                                    Text(
                                      data['eventName'],
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.description,
                                        color: Colors
                                            .brown), // Icon for description
                                    const SizedBox(width: 5),
                                    Text(
                                      'Description: ${data['description']}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        color: Colors.brown), // Icon for date
                                    const SizedBox(width: 5),
                                    Text(
                                      'Date: ${data['date']}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time,
                                        color: Colors.brown), // Icon for time
                                    const SizedBox(width: 5),
                                    Text(
                                      'Time: ${data['time']}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
