// ignore_for_file: unused_import

import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class TTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.montserrat(
      fontSize: 24, // Set your desired font size
      fontWeight: FontWeight.bold, // Set your desired font weight
      color: Colors.red, // Set your desired text color
    ),
  );

  static TextTheme dartTextTheme = TextTheme(
    headlineLarge: GoogleFonts.montserrat(
      fontSize: 24, // Set your desired font size
      fontWeight: FontWeight.bold, // Set your desired font weight
      color: Colors.red,
    ),
  );
}
