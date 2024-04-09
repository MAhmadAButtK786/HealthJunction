// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:healthjunction/src/features/authentication/screens/dashboard%20main%20home%20screen/nutrifithomescreens/dietshome.dart';

class DietDetailScreen extends StatelessWidget {
  final DietCardData data;

  const DietDetailScreen({Key? key, required this.data}) : super(key: key);

  // Define a color scheme
  static const Color accentColor = Colors.pinkAccent; // Existing accent color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat', // Example custom font
          ),
        ),
        backgroundColor: accentColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDietImage(context, data.image),
            const SizedBox(height: 16.0),
            _buildDietDetailsCard(data),
            const SizedBox(height: 24.0),
            _buildExpansionCards(data),
            const SizedBox(height: 24.0),
            _buildAdditionalInfoButton(context, data.additionalInfo),
          ],
        ),
      ),
    );
  }

  Widget _buildDietImage(BuildContext context, String imageUrl) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: InteractiveViewer(
                child: FadeInImage(
                  placeholder: const AssetImage('assets/placeholder_image.png'), // Replace with your asset
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  height: 200.0,
                ),
              ),
            );
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          height: 200.0,
        ),
      ),
    );
  }

  Widget _buildDietDetailsCard(DietCardData data) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
            ),
            const SizedBox(height: 8.0), // Spacing between title and description
            Text(
              data.description,
              style: const TextStyle(
                fontSize: 16.0,
                fontFamily: 'Montserrat', // Example custom font
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionCards(DietCardData data) {
    return Column(
      children: [
        _buildExpansionCard(' Advantages:', data.advantages),
        const SizedBox(height: 8.0),
        _buildExpansionCard(' Disadvantages:', data.disadvantages),
        const SizedBox(height: 8.0),
        _buildExpansionCard(' Foods to Avoid:', data.foodsToAvoid),
        const SizedBox(height: 8.0),
        _buildExpansionCard(' Foods to Eat:', data.foodsToEat),
      ],
    );
  }

  Widget _buildExpansionCard(String title, List<String> items) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
      ),
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: '${index + 1}. ', style: const TextStyle(fontSize: 16.0, color: Colors.black)),
                  TextSpan(
                    text: items[index],
                    style: const TextStyle(fontSize: 16.0, color: Colors.teal),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoButton(BuildContext context, String additionalInfo) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _launchURL(context, additionalInfo);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: accentColor,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: const Text(
          'Additional Information',
          style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Future<void> _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch URL')),
      );
    }
  }
}
