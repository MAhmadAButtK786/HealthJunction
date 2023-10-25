// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_screen/profile_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/text_string.dart';

class Navbar extends StatelessWidget {
  final Color color;
  final String textNav;
  const Navbar({super.key, required this.color, required this.textNav});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          LineAwesomeIcons.angle_left,
          color: tWhiteColor,
        ),
      ),
      title: Text(
        textNav,
        style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.to(() => ProfileScreen());
            },
            icon: const Icon(Icons.person))
      ],
      backgroundColor: color,
      centerTitle: true,
    ));
  }
}
