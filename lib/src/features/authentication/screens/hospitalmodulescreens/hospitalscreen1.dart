// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthjunction/src/features/authentication/screens/hospitalmodulescreens/hospitalscreen2.dart';
import 'package:healthjunction/src/features/authentication/screens/profile_icon_functions/profile_page/profile_main_page.dart';

import 'package:healthjunction/src/features/authentication/screens/sidebar/sidebar.dart';

// ignore: camel_case_types
class hospitalpage1 extends StatelessWidget {
  var height, width;
  TextEditingController searchController = TextEditingController();
  TextEditingController filterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: ReusableDrawerSideBar(
        color: Colors.blue,
        headerText: "Hospital",
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue,
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
                          Builder(builder: (context) {
                            return InkWell(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 30,
                              ),
                            );
                          }),
                          IconButton(
                            onPressed: () {
                              Get.to(() => ProfileMainPage());
                            },
                            icon: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                          )
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
                                              hintText: "Search Hospital",
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
                      title: Text("Hospital Name $index"),
                      subtitle: Text("Address $index"),
                      onTap: () {
                        Get.to(() => hospitalpage2());
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
