import 'package:HOMECARE/pages/workerscreens/worker_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

import '../../common/theme_helper.dart';
import '../../common/workerdrawer.dart';
import '../userscreens/changepassword.dart';

class WorkerProfileView extends StatefulWidget {
  const WorkerProfileView({Key? key}) : super(key: key);

  @override
  _WorkerProfileViewState createState() => _WorkerProfileViewState();
}

class _WorkerProfileViewState extends State<WorkerProfileView> {
  String profilePicLink = "";


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  String? Name;
  String? Place;
  String? Phone;
  String? Age;
  String? Profession;
  String? Aadhar;
  String imageUrl = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['email'] == _user?.email) {
          setState(() {
            Name = doc['name'];
            Place = doc['place'];
            Phone = doc['phone'];
            Age = doc['age'];
            Profession = doc['profession'];
            Aadhar = doc['aadhar_no'];
            imageUrl = doc['profilepicURL'];
          });
        }
      });
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Profile",textAlign: TextAlign.center),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35, top: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: Stack(
                    children: [
                      InkWell(
                        child: Container(
                          height: 200,
                          width: 200,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white12,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                        ),
                        onTap: (){
                          pickUploadProfilePic();
                        },
                      ),
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(bottom: 20),
                      //     child: IconButton(
                      //         onPressed: () {
                      //           //open image selector
                      //           getImage();
                      //         },
                      //         icon: const Icon(Icons.camera_alt_outlined)),
                      //   ),
                      // ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .8,
                      child: Text("Name: $Name"),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .8,
                      child: Text("Email: ${_user?.email}"),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .8,
                      child: Text("Address: $Place"),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .8,
                      child: Text("Phone No: $Phone"),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .8,
                      child: Text("Age: $Age"),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .8,
                      child: Text("Profession: $Profession"),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .8,
                      child: Text("Aadhar No: $Aadhar"),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[

                    FlatButton(
                      minWidth: 140,
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      onPressed: (){
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>WorkerProfileScreen()));
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.update),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Update Profile'),
                        ],
                      ),
                    ),
                    FlatButton(
                      minWidth: 140,
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>ChangePassword()));

                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.password),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Change Password'),
                        ],
                      ),
                    ),
                  ],
                ),

                // Container(
                //   decoration: ThemeHelper().buttonBoxDecoration(context),
                //   child: ElevatedButton(
                //     style: ThemeHelper().buttonStyle(),
                //     child: Padding(
                //       padding: EdgeInsets.fromLTRB(
                //           40, 10, 40, 10),
                //       child: Text('Update',
                //         style: TextStyle(fontSize: 20,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.white),),
                //     ),
                //     onPressed: () {
                //     },
                //   ),
                // ),
                // SizedBox(height: 10,),
                // Container(
                //   decoration: ThemeHelper().buttonBoxDecoration(context),
                //   child: ElevatedButton(
                //     style: ThemeHelper().buttonStyle(),
                //     child: Padding(
                //       padding: EdgeInsets.fromLTRB(
                //           5, 10, 5, 10),
                //       child: Text('Change Password',
                //         style: TextStyle(fontSize: 20,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.white),),
                //     ),
                //     onPressed: () {
                //     },
                //   ),
                // ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
      drawer:WorkerDrawer(),
    );
  }


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
        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>WorkerProfileView()));

      }
      );
    });
  }
}