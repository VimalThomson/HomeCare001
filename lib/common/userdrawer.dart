import 'package:HOMECARE/common/sample.dart';
import 'package:HOMECARE/pages/userscreens/pendingrequests.dart';
import 'package:HOMECARE/pages/userscreens/viewmyreviews.dart';
import 'package:HOMECARE/pages/userscreens/viewreviews.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../pages/login_page.dart';
import '../pages/services/usermanagement.dart';
import '../pages/userhome.dart';
import '../pages/userscreens/completedworks.dart';
import '../pages/userscreens/ongoingworks.dart';
import '../pages/userscreens/payments.dart';
import '../pages/userscreens/profile_view.dart';
import '../pages/userscreens/registercomplaint.dart';
import '../pages/userscreens/writereview.dart';
class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  _UserDrawerState createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  String? userName;
  String? userPlace;
  String? userPhone;
  String? email;
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
            email = doc['email'];
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
    return Drawer(
      backgroundColor: HexColor('#FDECECFF'),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            AppBar(
              title: Text('HomeCare '),
              backgroundColor:Colors.white,
              automaticallyImplyLeading: false,
            ),
            SizedBox(height: 10,),
            ListTile(

              tileColor: Colors.transparent,
              // leading: Text(''),
              leading: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(imageUrl),
            ),
              title: Text('$userName' , style: TextStyle( fontSize: 14, fontFamily: "alex"),),

              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>ProfileView()));

              },
            ),


            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Userhome()));

              },
            ),
            ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>ProfileView()));
                }
            ),

            ExpansionTile(
              leading: Icon(Icons.pending_actions_sharp),
              title: Text('Bookings'),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.pending_actions),
                    title: Text('Pending'),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>PendingRequests()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.incomplete_circle),
                    title: Text('Ongoing'),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>OngoingWorks()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.check),
                    title: Text('Completed'),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>CompletedWorks()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.currency_rupee),
                    title: Text('Payment'),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Payments()));
                    },
                  ),
                  // ListTile(
                  //   leading: Icon(Icons.currency_rupee),
                  //   title: Text('sample'),
                  //   onTap: () {
                  //     Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Sample()));
                  //   },
                  // )
                ],

            ),



            ExpansionTile(
              leading: Icon(Icons.rate_review),
              title: Text('Reviews'),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.reviews),
                  title: Text('Write Reviews'),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>WriteReview()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.rate_review_outlined),
                  title: Text('View my Reviews'),
                  onTap: () {
                     Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>ViewMyReviews()));



                  },
                ),
                ListTile(
                  leading: Icon(Icons.rate_review_outlined),
                  title: Text('View all Reviews'),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>ViewReviews()));


                  },
                ),
              ],

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
      ),
    );
  }
}
