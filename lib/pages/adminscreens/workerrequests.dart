import 'package:HOMECARE/pages/adminscreens/verifyworkers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:HOMECARE/common/admindrawer.dart';
class WorkerRequests extends StatefulWidget {
  const WorkerRequests({Key? key}) : super(key: key);

  @override
  _WorkerRequestsState createState() => _WorkerRequestsState();
}

class _WorkerRequestsState extends State<WorkerRequests> {


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
        stream: userref.where('status',isEqualTo: 'Verification Pending').where('role', isEqualTo: 'Worker1').snapshots(),
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
                final aadhar = documentSnapshot['aadhar_no'];
                final pic = documentSnapshot['profilepicURL'];
                final id = documentSnapshot.id;
                return  Card(
                    // shape: RoundedRectangleBorder(
                    //   side: BorderSide(color: Colors.blueAccent, width: 1),
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    margin: const EdgeInsets.all(15),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:5,vertical: 5),
                          child: ExpansionTileCard(
                            baseColor: Colors.white,
                            expandedColor: Colors.black,
                            expandedTextColor: Colors.white,
                            // key: cardA,
                            title: Text("Name : $name \nAddress : $address \nStatus: $status ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                            subtitle: Text("Phone No: $phone \nEmail: $email"),
                            children: <Widget>[
                              Divider(
                                thickness: 1.0,
                                height: 1.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),

                                child: InkWell(
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [

                                        Text(
                                          "Profession: $pro \Age: $age \nAadhar No: $aadhar" ,
                                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),

                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyWorkers(name, address, email, pic,pro, status,phone,age,id,aadhar)));
                                  },
                                ),
                              ),

                            ],
                          ),
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

