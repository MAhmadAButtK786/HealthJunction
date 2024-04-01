// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/profile_page/profile_main_page.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/profile_screen/profile_screen.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final Color color;
  final String textNav;
  final VoidCallback onMenuPressed;

  const Navbar({
    Key? key,
    required this.color,
    required this.textNav,
    required this.onMenuPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: onMenuPressed,
        icon: const Icon(
          Icons.menu,
         
          color: Colors.white,
        ),
      ),
      title: Text(
        textNav,
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(() => ProfileMainPage());
          },
          icon: const Icon(Icons.person, color: Colors.white,),
        ),
      ],
      backgroundColor: color,
      centerTitle: true,
    );
  }
}
