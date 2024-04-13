import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:healthjunction/src/features/authentication/screens/navbar/navbar.dart';
import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar2.dart';

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
        drawer: ReusableDrawerSideBar2(
          color: Colors.brown,
          headerText: "Event",
        ),
        appBar: const Navbar(
          color: Colors.brown,
          textNav: "Event",
          onMenuPressed: _handleMenuPressed,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Events Hosted by Us and Our Partners",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800], // Darker brown text
                  ),
                ),
              ),
              const SizedBox(height: 10),
              buildEventsList('Event'),
              const SizedBox(height: 10),
              buildEventsList('EventAdmins'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEventsList(String collection) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(collection).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
            return buildEventCard(data);
          },
        );
      },
    );
  }

  Widget buildEventCard(Map<String, dynamic> eventData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Card(
        elevation: 3.0, // Subtle elevation for depth
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Hero(
                      tag: eventData['imageUrl'],
                      child: Image.network(
                        eventData['imageUrl'],
                        height: 300,
                        width: 500,
                      ),
                    );
                  },
                );
              },
              child: Hero(
                tag: eventData['imageUrl'],
                child: Image.network(
                  eventData['imageUrl'],
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0), // Consistent padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventData['eventName'],
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[800], // Darker brown title
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              eventData['eventName'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.brown[800], // Darker brown title
                              ),
                            ),
                            content: SingleChildScrollView(
                              // Make content scrollable
                              child: Text(
                                eventData['description'],
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.brown[600]), // Readable description style
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  'Close',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.description,
                            size: 20.0, color: Colors.brown[500]),
                        const SizedBox(width: 5.0),
                        Flexible(
                          child: Text(
                            'Description:',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 20.0, color: Colors.brown[500]),
                      const SizedBox(width: 5.0),
                      Text(
                        'Date: ${eventData['date']}',
                        style: TextStyle(
                            fontSize: 16.0, color: Colors.brown[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Icon(Icons.access_time,
                          size: 20.0, color: Colors.brown[500]),
                      const SizedBox(width: 5.0),
                      Text(
                        'Time: ${eventData['time']}',
                        style: TextStyle(
                            fontSize: 16.0, color: Colors.brown[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  InkWell(
                    onTap: () {
                      setReminder(
                        eventData['eventName'],
                        eventData['date'],
                        eventData['time'],
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.alarm,
                            size: 20.0, color: Colors.brown[500]),
                        const SizedBox(width: 5.0),
                        Text(
                          'Set Reminder',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue[600],
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  InkWell(
                    onTap: () =>
                        launchMap(eventData['location']),
                    child: Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 24.0, color: Colors.brown[500]),
                        const SizedBox(width: 5.0),
                        Flexible(
                          child: Text(
                            'Location: ${eventData['location']}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blue[600],
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
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

  void setReminder(
    String eventName,
    String date,
    String time,
  ) async {
    DateTime eventDateTime = DateTime.parse('$date $time');

    final String title = Uri.encodeComponent(eventName);
    final String formattedDate =
        '${eventDateTime.year}${_formatTwoDigits(eventDateTime.month)}${_formatTwoDigits(eventDateTime.day)}';
    final String formattedTime =
        'T${_formatTwoDigits(eventDateTime.hour)}${_formatTwoDigits(eventDateTime.minute)}00';
    final String eventUrl =
        'https://calendar.google.com/calendar/render?action=TEMPLATE&text=$title&dates=$formattedDate$formattedTime/$formattedDate$formattedTime';

    if (await canLaunch(eventUrl)) {
      await launch(eventUrl);
    } else {
      throw 'Could not launch $eventUrl';
    }
  }

  String _formatTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }

  void launchMap(String location) async {
    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$location';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }
}
