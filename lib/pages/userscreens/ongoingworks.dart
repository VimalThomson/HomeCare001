import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../common/userdrawer.dart';
import 'complaintpage.dart';
class OngoingWorks extends StatefulWidget {
  const OngoingWorks({Key? key}) : super(key: key);

  @override
  _OngoingWorksState createState() => _OngoingWorksState();
}

class _OngoingWorksState extends State<OngoingWorks> {
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
        title: Text("",textAlign: TextAlign.center),
      ),
      body: StreamBuilder(
        stream: dataref.where("useruid",isEqualTo: _user?.uid).where("status",isEqualTo: "Ongoing").snapshots(),
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
                              ButtonBar(
                                alignment: MainAxisAlignment.spaceAround,
                                buttonHeight: 52.0,
                                buttonMinWidth: 90.0,
                                children: <Widget>[

                                  FlatButton(
                                    minWidth: 150,
                                    color: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0)),
                                    onPressed: () => launch("tel://$workerphone"),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(Icons.call),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                                        ),
                                        Text('Phone $workername'),
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    minWidth: 150,
                                    color: Colors.redAccent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0)),
                                    onPressed: () {
                                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Complaint(workername,workeremail,work)));
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Icon(Icons.report_problem_outlined),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                                        ),
                                        Text('Raise Complaint'),
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
      drawer: UserDrawer(),
    );
  }

}
