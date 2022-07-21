import 'package:HOMECARE/common/userdrawer.dart';
import 'package:HOMECARE/pages/userscreens/profile_view.dart';
import 'package:HOMECARE/pages/workerscreens/worker_profile_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../common/theme_helper.dart';
import '../../common/workerdrawer.dart';

class WorkerProfileScreen extends StatefulWidget {
  const WorkerProfileScreen({Key? key}) : super(key: key);

  @override
  _WorkerProfileScreenState createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fname = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController profession = new TextEditingController();
  TextEditingController aadhar = new TextEditingController();
  TextEditingController place = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();

  late String txtname,
      txtphone,
      txtemail,
      txtpassword,
      txtplace,
      txtage,
      txtprofession,
      txtaadhar,
      txtrole = '';


  final dbRef = FirebaseDatabase.instance.ref().child('users');
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('users');
  final _auth = FirebaseAuth.instance;
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  void update() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        "name" : txtname,
        "place" : txtplace,

      });
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>WorkerProfileView()));
    } catch(e){}
  }
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 180,),
              Container(
                child: Text("Update you details.",style: TextStyle(fontSize: 35,),),
              ),

              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Form(
                      //autovalidate: true,
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: Column(
                        children: [

                          SizedBox(height: 110,),
                          Container(
                            child: TextFormField(
                              controller: fname,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Name', 'Enter your name'),
                              onSaved: (value) {
                                txtname = value!;
                              },
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                if (val == null) {
                                  return "Can't be Empty";
                                }
                                if (!RegExp(
                                    r"(^[a-zA-Z][a-zA-Z\s]{0,20}[a-zA-Z]$)")
                                    .hasMatch(val)) {
                                  return "Enter a valid Name";
                                }
                                return null;
                              },
                            ),
                            decoration: ThemeHelper()
                                .inputBoxDecorationShaddow(),
                          ),



                          SizedBox(height: 20.0),
                          Container(
                            child: TextFormField(
                              controller: place,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Address', 'Enter your Address'),
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                txtplace = value!;
                              },
                              validator: (val) {
                                if (val == null) {
                                  return "Can't be empty";
                                }
                                if (!RegExp(
                                    r"(^[a-zA-Z][a-zA-Z\s]{0,20}[a-zA-Z]$)")
                                    .hasMatch(val)) {
                                  return "Enter a valid Address";
                                }
                                return null;
                              },
                            ),
                            decoration: ThemeHelper()
                                .inputBoxDecorationShaddow(),
                          ),

                          SizedBox(height: 20.0),
                          Container(

                            decoration: ThemeHelper().buttonBoxDecoration(
                                context),
                            child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      40, 10, 40, 10),
                                  child: Text(
                                    "Update".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    update();
                                  }
                                }

                              // },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      drawer:WorkerDrawer(),
    );
  }



}


