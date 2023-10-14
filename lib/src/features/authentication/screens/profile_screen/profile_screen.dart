// ignore_for_file: prefer_const_constructors, duplicate_ignore, unused_local_variable, prefer_const_literals_to_create_immutables, unused_import, library_private_types_in_public_api, unused_element

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthjunction/src/constants/colors.dart';
import 'package:healthjunction/src/constants/image_string.dart';
import 'package:healthjunction/src/constants/sizes.dart';
import 'package:healthjunction/src/constants/text_string.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_screen/update_profile_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    var iconColor = isDarkMode ? Colors.white : apptextColor;
    Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    Color textColor = isDarkMode ? Colors.white : Colors.black;
    Color buttonColor = isDarkMode ? Colors.blue : Colors.blue;
    Color iconBackgroundColor = isDarkMode
        ? tAccentColors.withOpacity(0.9)
        : tAccentColors.withOpacity(0.1);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(LineAwesomeIcons.angle_left, color: tWhiteColor),
          ),
          title: Center(
            child: Text(
              tProfile,
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
              icon: Icon(
                  isDarkMode ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
                  color: tWhiteColor),
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: isDarkMode
              ? Colors.black
              : Colors.white, // Set background color of the entire screen
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(tDefaultSize),
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 180,
                        height: 180,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(image: AssetImage(tProfileI)),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onDoubleTap: () {},
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: buttonColor,
                            ),
                            child: const Icon(
                              LineAwesomeIcons.alternate_pencil,
                              size: 22.0,
                              color: tWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    tUsername,
                    style: GoogleFonts.inter(fontSize: 25, color: textColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    tUserEmail,
                    style: GoogleFonts.inter(fontSize: 20, color: textColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => UpdateProfileScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: buttonColor,
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        tEditProfileB,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),

                  //Menu
                  ProfileMenuWidget(
                    title: "Settings",
                    icon: LineAwesomeIcons.cog,
                    onPress: () {},
                    endIcon: true,
                    textColor: textColor,
                    iconBackgroundColor: iconBackgroundColor,
                  ),
                  ProfileMenuWidget(
                    title: "Information",
                    icon: LineAwesomeIcons.info,
                    onPress: () {},
                    endIcon: true,
                    textColor: textColor,
                    iconBackgroundColor: iconBackgroundColor,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  ProfileMenuWidget(
                    title: "Logout",
                    icon: LineAwesomeIcons.alternate_sign_out,
                    textColor: Colors.red,
                    endIcon: true,
                    onPress: () {},
                    iconBackgroundColor: iconBackgroundColor,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    required this.endIcon,
    this.textColor,
    this.iconBackgroundColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  final Color? iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconBackgroundColor ?? Colors.transparent,
        ),
        child: Icon(
          icon,
          color: apptextColor,
        ),
      ),
      title: Text(
        title,
        style:
            GoogleFonts.inter(fontSize: 15, color: textColor ?? Colors.black),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white.withOpacity(0.6),
              ),
              child: const Icon(
                LineAwesomeIcons.angle_right,
                size: 20.0,
                color: apptextColor,
              ),
            )
          : null,
    );
  }
}
