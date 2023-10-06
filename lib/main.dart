// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_import

import 'package:flutter/material.dart';
import 'package:healthjunction/src/utils/theme/theme.dart';
import 'package:healthjunction/src/utils/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Junction',
      debugShowCheckedModeBanner: false, //To remove Debug
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Health Junction'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Health Junction'),
        ),
        body: Center(
          child: Text("Hello World"),
        ));
  }
}
