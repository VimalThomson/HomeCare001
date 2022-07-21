import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../common/userdrawer.dart';
class PendingRequests extends StatefulWidget {
  const PendingRequests({Key? key}) : super(key: key);

  @override
  _PendingRequestsState createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final CollectionReference dataref =
  FirebaseFirestore.instance.collection('workrequests');
  final User? _user = FirebaseAuth.instance.currentUser;
  // String? docid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Pending Requests",textAlign: TextAlign.center),
      ),
      body: StreamBuilder(
        stream: dataref.where("useruid",isEqualTo: _user?.uid).where("status",isEqualTo: "Pending").snapshots(),
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
                final docid = documentSnapshot.id;
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
                           subtitle: Text("Address : $address \nDate : $date"),
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
                                 FlatButton(
                                   minWidth: 150,
                                   color: Colors.redAccent,
                                   shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(4.0)),
                                   onPressed: () {
                                     cancelRequest(docid);
                                   },
                                   child: Column(
                                     children: <Widget>[
                                       Icon(Icons.close),
                                       Padding(
                                         padding: const EdgeInsets.symmetric(vertical: 2.0),
                                       ),
                                       Text('Cancel Request'),
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
  void cancelRequest(docid) async {
    try {
      FirebaseFirestore.instance.collection('workrequests').doc(docid).delete();
      Fluttertoast.showToast(msg: "The request has been canceled");
      print(docid);
      // Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Carpenter()));
    } catch(e){
      print(e.toString());
    }

  }
}
