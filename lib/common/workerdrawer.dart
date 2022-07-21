import 'package:HOMECARE/pages/workerhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../pages/login_page.dart';
import '../pages/services/usermanagement.dart';
import '../pages/workerscreens/availablejobs.dart';
import '../pages/workerscreens/completedjobs.dart';
import '../pages/workerscreens/ongoingjobs.dart';
import '../pages/workerscreens/worker_profile_view.dart';
class WorkerDrawer extends StatefulWidget {
  const WorkerDrawer({Key? key}) : super(key: key);

  @override
  _WorkerDrawerState createState() => _WorkerDrawerState();
}

class _WorkerDrawerState extends State<WorkerDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  String? userName;
  String? userPlace;
  String? userPhone;
  String? email;
  String? work;
  // double? rating;
  String imageUrl = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('users').where('role',isEqualTo: 'Worker').
        get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['email'] == _user?.email) {
          setState(() {
            email = doc['email'];
            userName = doc['name'];
            userPlace = doc['place'];
            userPhone = doc['phone'];
            userName = doc['name'];
            work = doc['profession'];
            imageUrl = doc['profilepicURL'];
            // rating = doc['rating'];
          });
        }
      });
    });

  }
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: HexColor('#FDECECFF'),

      child: Column(
        children: <Widget>[

          AppBar(
            title: Text('HomeCare'),
            backgroundColor:Colors.white,
            automaticallyImplyLeading: false,

          ),
          ListTile(
            tileColor: Colors.transparent,
            // leading: Text(''),
            leading: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(imageUrl),
            ),
            title: Text('$userName \n$work', style: TextStyle( fontSize: 16, fontFamily: "alex"),),

            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>WorkerHome()));
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.pending_actions_sharp),
            title: Text('Jobs'),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.pending_actions),
                title: Text('Available Jobs'),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>AvailableJobs()));
                },
              ),
              ListTile(
                leading: Icon(Icons.incomplete_circle),
                title: Text('Ongoing Jobs'),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>OngoingJobs()));

                },
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text('Completed Jobs'),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>CompletedJobs()));


                },
              )
            ],

          ),
          ListTile(
              leading: Icon(Icons.edit),
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>WorkerProfileView()));
              }
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('LogOut'),
            onTap: () {
              UserManagement().signOut();
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> LoginPage()));
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
                  ModalRoute.withName('/')
              );

            },
          ),
        ],
      ),
    );
  }
}
