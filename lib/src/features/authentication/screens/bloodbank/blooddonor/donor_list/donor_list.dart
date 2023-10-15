import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_screen/profile_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DonorList extends StatefulWidget {
  const DonorList({super.key});

  @override
  State<DonorList> createState() => _DonorListState();
}

class _DonorListState extends State<DonorList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            LineAwesomeIcons.angle_left,
            color: tWhiteColor,
          ),
        ),
        title: Text(
          tBloodBank,
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => ProfileScreen());
              },
              icon: Icon(Icons.person))
        ],
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
    );
  }
}
