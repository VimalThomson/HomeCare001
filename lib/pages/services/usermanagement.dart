

import 'package:HOMECARE/pages/adminpage.dart';
import 'package:HOMECARE/pages/registration_page.dart';
import 'package:HOMECARE/pages/userhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';



class UserManagement{



  final User? user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;




  void signOut() async {

    FirebaseAuth.instance.signOut().then((_){
      print('success logging out');

    }).catchError((e) {
      print('failure logging out');
      print(e);
    });
  }

}


