// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LabSearchBar extends StatefulWidget {
  const LabSearchBar({super.key});

  @override
  State<LabSearchBar> createState() => _LabSearchBarState();
}

class _LabSearchBarState extends State<LabSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Card(
            child: TextField(
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search), hintText: 'Search...'),
        )),
      ),
    ));
  }
}
