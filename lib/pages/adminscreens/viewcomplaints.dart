import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import '../../common/admindrawer.dart';
class ViewComplaints extends StatefulWidget {
  const ViewComplaints({Key? key}) : super(key: key);

  @override
  _ViewComplaintsState createState() => _ViewComplaintsState();
}

class _ViewComplaintsState extends State<ViewComplaints> {
  final CollectionReference dataref =
  FirebaseFirestore.instance.collection('complaints');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Complaints",textAlign: TextAlign.center),
      ),
      body: StreamBuilder(
        stream: dataref.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];
                final username = documentSnapshot['username'];
                final worker = documentSnapshot['Worker_Name'];
                final date1 = documentSnapshot['Date'];
                final complaint = documentSnapshot['Complaint'];
                final workerpro = documentSnapshot['worker_profession'];
                final id = documentSnapshot.id;
                final date = date1.toString();
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  margin: const EdgeInsets.all(15),
                    child: ExpansionTileCard(
                      baseColor: Colors.white,
                      expandedColor: Colors.black,
                      expandedTextColor: Colors.white,
                      // key: cardA,
                      title: Text("Username : $username \nComplaint against : $worker",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                      subtitle: Text("Date : $date"),
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
                                  "Complaint : $complaint \nWorker Profession : $workerpro",
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
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0)),
                              onPressed: () {

                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.check),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                                  ),
                                  Text('Take Action'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
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
      drawer: AdminDrawer(),
    );
  }
}
