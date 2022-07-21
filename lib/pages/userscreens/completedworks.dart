import 'package:HOMECARE/pages/userscreens/rateworker.dart';
import 'package:printing/printing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../common/userdrawer.dart';
import 'package:pdf/pdf.dart';
class CompletedWorks extends StatefulWidget {
  const CompletedWorks({Key? key}) : super(key: key);

  @override

  _CompletedWorksState createState() => _CompletedWorksState();
}

class _CompletedWorksState extends State<CompletedWorks> {
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
        stream: dataref.where("useruid",isEqualTo: _user?.uid).where("status",isEqualTo: "Completed ").snapshots(),
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
                final costlb = documentSnapshot['cost_of_labour'];
                final addcosts = documentSnapshot['additional_costs'];
                final total = documentSnapshot['totalrate'];
                final status = documentSnapshot['status'];
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
                                    onPressed: () {
                                      Printing.layoutPdf(
                                          onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
                                            format: format,
                                            html: '<html><head><title>HomeCare</title></head><body><div class="invoice-box"><table cellpadding="2" cellspacing="2"><tr class="top"><td colspan="2"><table><tr><td class="title"><img src="https://firebasestorage.googleapis.com/v0/b/homecare03.appspot.com/o/logo1.jpg?alt=media&token=faf227ee-7772-40e4-a601-66dbd62d5918" style="width: 100%; max-width: 300px" /></td><td>Invoice id: ${id}<br/>Bill Generation Date: ${date}<br /></td></tr></table></td></tr><tr class="information"><td colspan="2"><table border: 1px;><tr><td></td><td>HomeCare<br />Username: ${userName}<br />Email: ${username}</td></tr><table width="400"><tr><th>Payment Mode:</th><th>Online</th></tr></table><br><br><table border = "1"  width="400"><tr><th>Description</th><th>Cost</th></tr><tr><td>Cost of Labour:</td><td>${costlb}</td></tr><tr><td>Additional costs:</td><td>${addcosts}</td></tr><tr><td>Total Costs:</td><td>${total}</td></tr></table><br><br><table width="400"><tr><th>Payment Status:</th><th>${status}</th></tr></table></div></body></html>',
                                          ));
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Icon(Icons.currency_rupee_rounded),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                                        ),
                                        Text('Invoice'),
                                      ],
                                    ),
                                  ),

                                  FlatButton(
                                    minWidth: 150,
                                    color: Colors.blueAccent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0)),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RateWorker(workeruid)));


                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Icon(Icons.star_rate),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                                        ),
                                        Text('Rate $workername'),
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
