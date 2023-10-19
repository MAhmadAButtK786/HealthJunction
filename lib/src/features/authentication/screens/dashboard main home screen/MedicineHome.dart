import 'package:flutter/material.dart';

class Medicinehome extends StatelessWidget {
  var height,width;

  List imgData=[
    /* "images/hospital.jpeg",
    "images/hospital.jpeg",
    "images/clinic.jpeg",
    "images/bloodbank.jpeg",
    "images/bloodbank.jpeg",
    "images/bloodbank.jpeg",*/
    "images/medcine.jpeg",
  ];
  List titles=[
    " Medicine Suppliers  ",


  ];
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.green,
          child: Column(

            children: [
              Container(
                decoration: BoxDecoration(

                  /* borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),

                  ),*/
                ),
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
                            onTap: (){},
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
                                image: DecorationImage(image: AssetImage("images/women.png",))

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
                            "              Medicine  ",
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

                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.8,
                      mainAxisSpacing: 45,
                      crossAxisSpacing: 20
                  ),
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: titles.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){},
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow:[
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 7,
                              blurRadius: 9,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(imgData[index],
                              width: 100,
                            ),
                            Text(
                              titles[index],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
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

