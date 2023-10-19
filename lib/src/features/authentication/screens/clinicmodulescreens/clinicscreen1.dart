// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_typing_uninitialized_variables, camel_case_types, prefer_const_constructors, unnecessary_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:healthjunction/src/features/authentication/screens/clinicmodulescreens/clinicscreen2.dart';

class clinicpage1 extends StatelessWidget {
  var height, width;
  TextEditingController searchController = TextEditingController();
  TextEditingController filterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.purple,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(),
                height: height * 0.25,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 35,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.sort,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage("images/women.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.search,
                                          color: Colors.grey,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: searchController,
                                            decoration: InputDecoration(
                                              hintText: "Search Clinic",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.filter_list,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                height: height * 0.75,
                width: width,
                child: ListView.builder(
                  itemCount: 12, // Number of items in your list
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("images/hospital.jpg"),
                      ),
                      title: Text("Clinic Name $index"),
                      subtitle: Text("Address $index"),
                      onTap: () {
                        Get.to(() => clinicpage2());
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
