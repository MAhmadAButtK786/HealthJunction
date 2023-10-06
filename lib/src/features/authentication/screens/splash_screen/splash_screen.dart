// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:healthjunction/src/constants/colors.dart';
// import 'package:healthjunction/src/constants/image_string.dart';
// import 'package:healthjunction/src/constants/text_string.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(children: [
//         Positioned(
//             top: 80,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   tAppName,
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//                 Text(
//                   tAppTagLine,
//                   style: Theme.of(context).textTheme.headlineSmall,
//                 ),
//               ],
//             )),
//         Positioned(
//           bottom: 1000,
//           child: Image(image: AssetImage(tSplashImage)),
//         ),
//         Positioned(
//             child: Container(
//           width: 100,
//           height: 200,
//           color: apptextColor,
//         ))
//       ]),
//     );
//   }
// }
