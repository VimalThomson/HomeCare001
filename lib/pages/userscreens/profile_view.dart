import 'package:HOMECARE/common/userdrawer.dart';
import 'package:HOMECARE/common/workerdrawer.dart';
import 'package:HOMECARE/pages/userscreens/edit_profile.dart';
import 'package:HOMECARE/pages/userscreens/sample.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:HOMECARE/common/image_selector.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:HOMECARE/common/theme_helper.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

import 'changepassword.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  String profilePicLink = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  String? userName;
  String? userPlace;
  String? userPhone;
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
            userName = doc['name'];
            userPlace = doc['place'];
            userPhone = doc['phone'];
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
      body: Padding(
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
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(imageUrl),

                        ),
                      ),onTap: (){
                      pickUploadProfilePic();

                    },
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                  // padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
                  child: Container(
                    height: 57,
                    width: MediaQuery.of(context).size.width * .8,
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: ListTile(
                                title: Text("Name: $userName", style: TextStyle(fontSize: 16),),
                            trailing: IconButton(onPressed: () { Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) => UpdateUserProfile(userName!, userPlace!))); }, icon: Icon(Icons.edit), )

                              ,)
                        ),

                      ],
                    ),
                  ),
                ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * .8,
                    child: Text("Email: ${_user?.email}",style: TextStyle(fontSize: 16)),

                  ),
                ),
              ),
              Card(
                child: Container(
                  height: 57,
                  width: MediaQuery.of(context).size.width * .8,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ListTile(
                            title: Text("Address: $userPlace",style: TextStyle(fontSize: 16)),
                            trailing: IconButton(onPressed: () { Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) => UpdateUserProfile(userName!, userPlace!))); }, icon: Icon(Icons.edit), )

                            ,)
                      ),

                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * .8,
                    child: Text("Phone No: $userPhone",style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
              SizedBox(height: 180.0),

              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                buttonHeight: 52.0,
                buttonMinWidth: 90.0,
                children: <Widget>[

                  FlatButton(
                    minWidth: 340,
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
              SizedBox(height: 10,),

            ],

          ),
        ),
      ),
      drawer: UserDrawer(),
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
      });
    });
  }

}