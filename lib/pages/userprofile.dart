
import 'package:HOMECARE/pages/userhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../common/theme_helper.dart';
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String imageUrl = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';

  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('users');
  final _auth = FirebaseAuth.instance;
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  String profilePicLink = "";
  final User? _user = FirebaseAuth.instance.currentUser;

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
        "status" : "Online"
      });
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Userhome()));
    } catch(e){}
  }

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
            imageUrl = doc['profilepicURL'];
          });
        }
      });
    });

  }
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
                child: Text("Please update your profile picture before proceeding further", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
              ),
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
              SizedBox(height: 20.0),
              Container(

                decoration: ThemeHelper().buttonBoxDecoration(
                    context),
                child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          10, 10, 10, 10),
                      child: Text(
                        "Proceed to HOME",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () {
                        update();
                        //register1();

                    }

                  // },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }



}


