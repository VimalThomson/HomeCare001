import 'dart:ui';

import 'package:HOMECARE/common/workerdrawer.dart';
import 'package:HOMECARE/pages/services/usermanagement.dart';
import 'package:HOMECARE/pages/workerscreens/availablejobs.dart';
import 'package:HOMECARE/pages/workerscreens/completedjobs.dart';
import 'package:HOMECARE/pages/workerscreens/ongoingjobs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'login_page.dart';


class WorkerHome extends StatelessWidget {
  final CollectionReference dataref =
  FirebaseFirestore.instance.collection('reviews');
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("HomeCare",textAlign: TextAlign.center),
      ),
      body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(height: 20,),
            InkWell(
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black),
                  gradient: LinearGradient(colors: [Colors.blueAccent, Colors.cyan]),

                ),
                width: 350,
                height: 150,
                child: Center(child: Text('Available Jobs', style: TextStyle(fontSize: 25),)),
              ), onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => AvailableJobs()));
            }
            ),
            SizedBox(height: 20,),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black),
                  gradient: LinearGradient(colors: [Colors.blueAccent, Colors.cyan]),
                ),
                width: 350,
                height: 150,
                child: Center(child: Text('Ongoing jobs', style: TextStyle(fontSize: 25),)),
              ),onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => OngoingJobs()));
            }
            ),
            SizedBox(height: 20,),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black),
                  gradient: LinearGradient(colors: [Colors.blueAccent, Colors.cyan]),

                ),
                width: 350,
                height: 150,
                child: Center(child: Text('Completed jobs', style: TextStyle(fontSize: 25),)),
              ),
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>CompletedJobs()));

              },
            ),
            SizedBox(height: 20,),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black),
                  gradient: LinearGradient(colors: [Colors.blueAccent, Colors.cyan]),

                ),
                width: 350,
                height: 150,
                child: Center(child: Text('Logout', style: TextStyle(fontSize: 25),)),
              ),onTap: (){
              UserManagement().signOut();
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> LoginPage()));
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
                  ModalRoute.withName('/')
              );
            },
            ),
            SizedBox(height: 20,),
          ],
        ),



      drawer:WorkerDrawer(),
    );
  }
}

