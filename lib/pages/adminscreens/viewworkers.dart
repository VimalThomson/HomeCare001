import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:HOMECARE/common/admindrawer.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../common/theme_helper.dart';
import 'workerinfo.dart';

class ViewWorkers extends StatefulWidget {
  const ViewWorkers({Key? key}) : super(key: key);

  @override
  _ViewWorkersState createState() => _ViewWorkersState();
}

class _ViewWorkersState extends State<ViewWorkers> {
  late String name1,address1;
  final CollectionReference userref =
  FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Workers",textAlign: TextAlign.center),
      ),
      body: StreamBuilder(
        stream: userref.where('role',isEqualTo: 'Worker').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];
                final name = documentSnapshot['name'];
                final address = documentSnapshot['place'];
                final phone = documentSnapshot['phone'];
                final email = documentSnapshot['email'];
                final pro = documentSnapshot['profession'];
                final age = documentSnapshot['age'];
                final status = documentSnapshot['status'];
                final pic = documentSnapshot['profilepicURL'];
                final id = documentSnapshot.id;
                return InkWell(
                  child: Card(
                    color: HexColor('#FDECECFF'),

                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blueAccent, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(15),
                    child: ListTile(

                      title: Text("Name : $name \nAddress : $address \nStatus: $status" ),
                      // subtitle: Row(
                      //   children: <Widget>[
                      //
                      //           Expanded(
                      //               child: RaisedButton(
                      //                   onPressed: () {
                      //                     block(id);
                      //                   },
                      //                   color: Colors.black,
                      //                   child: Text("Block", style: TextStyle(color: Colors.white),)
                      //               )
                      //           ),
                      //           Expanded(
                      //               child: RaisedButton(
                      //                   onPressed: () {
                      //                     unblock(id);
                      //                   },
                      //                   color: Colors.white,
                      //                   child: Text("UnBlock", style: TextStyle(color: Colors.black),)
                      //               )
                      //           ),
                      //
                      //
                      //   ],
                      // ),
                      trailing: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(pic),
                      ),
                      ),

                  ),
                  onTap: (){
                    // print("pressed");

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkerInfo(name, address, email, pro, status,pic,phone,age,id)));

                  },

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

  void block(id) async {
    try {

      FirebaseFirestore.instance.collection('users').doc(id).update({
      "status" : 'Blocked',
      });
    } catch(e){}
  }
  void unblock(id) async {
    try {

      FirebaseFirestore.instance.collection('users').doc(id).update({
        "status" : 'Online',
      });
    } catch(e){}
  }
}


