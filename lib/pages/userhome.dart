
import 'package:HOMECARE/common/userdrawer.dart';
import 'package:HOMECARE/pages/screens/job-carpenter.dart';
import 'package:HOMECARE/pages/screens/job-electric.dart';
import 'package:HOMECARE/pages/screens/job-electricalservices.dart';
import 'package:HOMECARE/pages/screens/job-mechanic.dart';
import 'package:HOMECARE/pages/screens/job-painter.dart';
import 'package:HOMECARE/pages/screens/job-plumber.dart';
import 'package:HOMECARE/pages/userscreens/viewreviews.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class Userhome extends StatelessWidget {
  final CollectionReference dataref =
  FirebaseFirestore.instance.collection('reviews');
  final List<String> imageList = [
    'assets/images/p_electric.jpg',
    'assets/images/p_mechanic.png',
    'assets/images/p_carpenter.webp'

  ];

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 250;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("HomeCare",textAlign: TextAlign.center),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            margin: EdgeInsets.all(0),
            child: CarouselSlider.builder(
              itemCount: imageList.length,
              options: CarouselOptions(
                enlargeCenterPage: true,
                height: 200,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                reverse: false,
                aspectRatio: 5.0,
              ),
              itemBuilder: (context, i, id){
                //for onTap to redirect to another screen
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black,)
                    ),
                    //ClipRRect for image border radius
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        imageList[i],
                        width: 700,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  onTap: (){
                    var url = imageList[i];
                    print(url.toString());
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height -
                //appBar2.preferredSize.height -
                MediaQuery.of(context).padding.top) *
                0.01,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.075,
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.35,
                width: MediaQuery.of(context).size.width * 0.4,

                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 5.0,blurStyle: BlurStyle.normal),],
                    // border: Border.all(color: Colors.blueAccent),
                    image: new DecorationImage(
                        image: new AssetImage('assets/images/Mechanic.gif'),
                        fit: BoxFit.contain),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    )
                ),
                child: GestureDetector(onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>Mechanic(),
                    ),
                  );
                },    child: null),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.35,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 10.0,blurStyle: BlurStyle.normal),],
                    // border: Border.all(color: Colors.blueAccent),
                    image: new DecorationImage(
                        image: new AssetImage('assets/images/Carpenter.gif'),
                        fit: BoxFit.contain),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    )),
                child: GestureDetector(onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>Carpenter(),
                    ),
                  );
                },
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.075,
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.35,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 10.0,blurStyle: BlurStyle.normal),],
                    // border: Border.all(color: Colors.blueAccent),
                    image: new DecorationImage(
                        image: new AssetImage('assets/images/electrical.gif'),
                        fit: BoxFit.contain),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    )),
                child: GestureDetector(onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>Electrical(),
                    ),
                  );
                },child: null),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.35,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 10.0,blurStyle: BlurStyle.normal),],
                    // border: Border.all(color: Colors.blueAccent),
                    image: new DecorationImage(
                        image: new AssetImage('assets/images/electricalrepair.gif'),
                        fit: BoxFit.contain),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    )),
                child: GestureDetector(onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>ElectricalServices(),
                    ),
                  );
                },child: null),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.075,
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.35,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 10.0,blurStyle: BlurStyle.normal),],
                    // border: Border.all(color: Colors.blueAccent),
                    image: new DecorationImage(
                        image: new AssetImage('assets/images/Plumber.gif'),
                        fit: BoxFit.contain),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    )),
                child: GestureDetector(onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>Plumber(),
                    ),
                  );
                },child: null),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.35,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 10.0,blurStyle: BlurStyle.normal),],
                    // border: Border.all(color: Colors.blueAccent),
                    image: new DecorationImage(
                        image: new AssetImage('assets/images/Painter.gif'),
                        fit: BoxFit.contain),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    )),
                child: GestureDetector(onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>Painting(),
                    ),
                  );
                },child: null),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.075,
              ),


            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              SizedBox(height: 30,),
              InkWell(
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width*0.85,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Align(
                      alignment: Alignment.center,child: Text('User Reviews', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)),
                ),
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>ViewReviews()));

                },
              ),
              SizedBox(height: 25,),
            ],
          ),
        ],
      ),
      drawer: UserDrawer(),
    );
  }
}

