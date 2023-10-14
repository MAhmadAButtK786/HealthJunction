// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DonorForm extends StatefulWidget {
  const DonorForm({super.key});

  @override
  State<DonorForm> createState() => _DonorFormState();
}

class _DonorFormState extends State<DonorForm> {
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
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.red.withOpacity(0.3),
          child: Column(children: []),
        ));
  }
}
