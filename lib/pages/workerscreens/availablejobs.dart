import 'package:HOMECARE/common/workerdrawer.dart';
import 'package:HOMECARE/pages/workerscreens/ongoingjobs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/admindrawer.dart';
import '../../common/userdrawer.dart';
class AvailableJobs extends StatefulWidget {
  const AvailableJobs({Key? key}) : super(key: key);

  @override
  _AvailableJobsState createState() => _AvailableJobsState();
}

class _AvailableJobsState extends State<AvailableJobs> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final CollectionReference dataref =
  FirebaseFirestore.instance.collection('workrequests');
  final User? _user = FirebaseAuth.instance.currentUser;
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? userName;
  String? userPlace;
  String? userPhone;
  String? email;
  String? workk;
  String? docid;
  String imageUrl = 'assets/images/profile.jpg';

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['email'] == user?.email) {
          setState(() {
            email = doc['email'];
            userName = doc['name'];
            userPlace = doc['place'];
            userPhone = doc['phone'];
            imageUrl = doc['profilepicURL'];
            workk = doc['profession'];
          });
        }
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Available Jobs",textAlign: TextAlign.center),
      ),
      body: StreamBuilder(
        stream: dataref.where("work",isEqualTo: workk).where("status",isEqualTo: "Pending").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];
                final date = documentSnapshot['Date'];
                final address = documentSnapshot['address'];
                final instructions = documentSnapshot['instructions'];
                final username = documentSnapshot['username'];
                final id = _user?.uid;
                final useruid = documentSnapshot['useruid'];
                final work = documentSnapshot['work'];
                final workrequest = documentSnapshot['work_request'];
                final worktpye = documentSnapshot['worktype'];
                docid = documentSnapshot.id;
                return Container(
                  // child: Text("$date,$address,$instructions,$username,$id,$useruid,$work,$worktpye,$workrequest"),
                  child: Container(
                    width: 100,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                          child: ExpansionTileCard(
                            baseColor: Colors.white,
                            expandedColor: Colors.black,
                            expandedTextColor: Colors.white,
                            // key: cardA,
                            title: Text("Work : $work, $worktpye",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                            subtitle: Text("User : $username \nAddress : $address \nDate : $date"),
                            children: <Widget>[
                              Divider(
                                thickness: 1.0,
                                height: 1.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 8.0,
                                  ),
                                  child: Text(
                                    "Work Request : $workrequest \nInstructions : $instructions",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.spaceAround,
                                buttonHeight: 52.0,
                                buttonMinWidth: 90.0,



                                children: <Widget>[
                                  // FlatButton(
                                  //   shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(4.0)),
                                  //   onPressed: () {
                                  //     //cardA.currentState?.expand();
                                  //   },
                                  //   child: Column(
                                  //     children: <Widget>[
                                  //       Icon(Icons.arrow_downward),
                                  //       Padding(
                                  //         padding: const EdgeInsets.symmetric(vertical: 2.0),
                                  //       ),
                                  //       Text('Open'),
                                  //     ],
                                  //   ),
                                  // ),
                                  // FlatButton(
                                  //   shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(4.0)),
                                  //   onPressed: () {
                                  //     //cardA.currentState?.collapse();
                                  //   },
                                  //   child: Column(
                                  //     children: <Widget>[
                                  //       Icon(Icons.arrow_upward),
                                  //       Padding(
                                  //         padding: const EdgeInsets.symmetric(vertical: 2.0),
                                  //       ),
                                  //       Text('Close'),
                                  //     ],
                                  //   ),
                                  // ),
                                  FlatButton(
                                    minWidth: 150,
                                    color: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0)),
                                    onPressed: () {
                                      takeJob(docid);

                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Icon(Icons.check),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                                        ),
                                        Text('Take Job'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      drawer: WorkerDrawer(),
    );
  }

  void takeJob(docid) async {
    try {

      FirebaseFirestore.instance.collection('workrequests').doc(docid).update({
        "worker_username" : _user?.email,
        "worker_useruid":_user?.uid,
        "worker_name" : userName,
        "worker_phone" : userPhone,
        "status" : "Ongoing",
        // "duration": duration
      });
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>OngoingJobs()));
    } catch(e){
      print(e.toString());
    }

  }
}
