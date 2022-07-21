import 'package:HOMECARE/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../common/theme_helper.dart';
class AgeValidator {
  static String? validate(String value) {
    if (value == null) {
      return "Can't be empty";
    }
    if (!RegExp(r"^[0-9]{2}$").hasMatch(value)) {
      return "Enter a valid Age";
    }
  }
}

class AadharValidator {
  static String? validate(String value) {
    if (value == null) {
      return "Can't be empty";
    }
    if (!RegExp(r"^[0-9]{12}$").hasMatch(value)) {
      return "Enter a valid aadhar number";
    }
  }
}

class WorkerProfileScreen1 extends StatefulWidget {
  const WorkerProfileScreen1({Key? key}) : super(key: key);

  @override
  _WorkerProfileScreen1State createState() => _WorkerProfileScreen1State();
}

class _WorkerProfileScreen1State extends State<WorkerProfileScreen1> {
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
      txtprofession='',
      txtaadhar,
      txtrole = '';


  final dbRef = FirebaseDatabase.instance.ref().child('users');
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('users');
  final _auth = FirebaseAuth.instance;
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  String profilePicLink = "";

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
      maxWidth: 1024,
      imageQuality: 90,
    );
    final User? user = FirebaseAuth.instance.currentUser;

    Reference ref = FirebaseStorage.instance
        .ref().child('profile${user?.uid}');

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
        final User? user = FirebaseAuth.instance.currentUser;
        final fire = FirebaseFirestore.instance.collection('users');
        fire.doc(user!.uid).update({
          "profilepicURL": profilePicLink
        });
      });
    });
  }
  void update() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        "age" : txtage,
        "profession" : txtprofession,
        "aadhar_no" : txtaadhar,
        "status" : "Verification Pending",
        "role" : 'Worker1',
        "rating": 5
      });
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => LoginPage()));
      Fluttertoast.showToast(msg: 'Profile Updated Succesfully. \nVerification not Completed yet.');
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
              SizedBox(height: 60,),
              Container(
                child: Text("Please update your profile picture and fill in other details, before proceeding further", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
              ),
              GestureDetector(
                onTap: () {
                  pickUploadProfilePic();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 60, bottom: 0),
                  height: 150,
                  width: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: primary,
                  ),
                  child:
                  Center(
                    child:
                    profilePicLink == " " ?
                    const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 80,
                    ) :
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.white12,
                      backgroundImage: NetworkImage(profilePicLink),
                    ),
                  ),
                ),
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


                          SizedBox(height: 40,),

                          Container(
                            child: TextFormField(
                              controller: age,

                              decoration: ThemeHelper().textInputDecoration(
                                  "Age",
                                  "Enter your Age"),
                              keyboardType: TextInputType.number,
                              onSaved: (value) {
                                txtage = value!;
                              },
                              // validator: (val) {
                              //   if (val == null) {
                              //     return "Can't be empty";
                              //   }
                              //   if (!RegExp(r"^[0-9]{2}$").hasMatch(val)) {
                              //     return "Enter a valid Age";
                              //   }
                              //   return null;
                              // },
                              validator:(value)=> AgeValidator.validate(value!),

                            ),
                            decoration: ThemeHelper()
                                .inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 20.0),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'Profession',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0), borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return "Select One";
                              }
                            },
                            value: txtprofession.isNotEmpty ? txtprofession : null,
                            items: <String>['Mechanic', 'Electrician','Painter','Carpenter', 'Plumber']
                                .map<DropdownMenuItem<String>>((String value)
                            {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),);
                            }).toList(),
                            onChanged: (value){
                              setState(() {
                                txtprofession = value.toString();
                              });
                            },
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: TextFormField(
                              controller: aadhar,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Aadhar Number",
                                  "Enter your Aadhar number"),
                              keyboardType: TextInputType.number,
                              onSaved: (value) {
                                txtaadhar = value!;
                              },
                              // validator: (val) {
                              //   if (val == null) {
                              //     return "Select One";
                              //   }
                              //   if (!RegExp(r"^[0-9]{12}$").hasMatch(val)) {
                              //     return "Enter a valid aadhar number";
                              //   }
                              //   return null;
                              // },
                              validator:(value)=> AadharValidator.validate(value!),

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
                                    //register1();
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

    );
  }



}


