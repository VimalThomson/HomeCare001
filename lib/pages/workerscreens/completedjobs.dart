import 'package:HOMECARE/pages/userscreens/rateworker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../common/userdrawer.dart';
// import 'complaintpage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../common/workerdrawer.dart';
class CompletedJobs extends StatefulWidget {
  const CompletedJobs({Key? key}) : super(key: key);

  @override

  _CompletedJobsState createState() => _CompletedJobsState();
}

class _CompletedJobsState extends State<CompletedJobs> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final CollectionReference dataref =
  FirebaseFirestore.instance.collection('workrequests');
  final User? _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Completed",textAlign: TextAlign.center),
      ),
      body: StreamBuilder(
        stream: dataref.where("worker_useruid",isEqualTo: _user?.uid).where("status",isEqualTo: "Completed ").snapshots(),
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
                final userphone = documentSnapshot['user_phone_number'];
                final workername = documentSnapshot['worker_name'];
                final workerphone = documentSnapshot['worker_phone'];
                final workeremail  = documentSnapshot['worker_username'];
                final userName = documentSnapshot['userName'];
                final workeruid = documentSnapshot['worker_useruid'];
                final docid = documentSnapshot.id;


                return Container(
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
                            title: Text("Work : $work, $worktpye \nName : $userName",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                            subtitle: Text("Address : $address \nDate : $date"),
                            children: <Widget>[
                              Divider(
                                thickness: 1.0,
                                height: 1.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),

                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [

                                      Text(
                                        "Work Request : $workrequest \nInstructions : $instructions \nWorker Name : $workername \nWorker email : $workeremail",
                                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),

                                ),
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

}
