import 'package:flutter/material.dart';

class Medicine2 extends StatelessWidget {
  var height, width;

  // Mock data for the list
  List<String> mockData = [
    " Medicine suppliers 1  and there data, links ",
    " Medicine suppliers 2  and there data, links ",
    " Medicine suppliers 3  and there data, links ",
    " Medicine suppliers 4  and there data, links ",
    " Medicine suppliers 5  and there data, links ",

  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.green,
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
                          Text(
                            "             Medicine  ",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            "             Suppliers  ",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "             Innovative App for Health Care",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white54,
                              letterSpacing: 1,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Add a list of mock data in the white part
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: mockData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(mockData[index]),
                      // Add more styling or widgets as needed
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
