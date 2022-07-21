import 'package:HOMECARE/pages/userscreens/paymentspage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../common/userdrawer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  late Razorpay _razorpay;
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  // final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final CollectionReference dataref =
  FirebaseFirestore.instance.collection('payment');
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Payments",textAlign: TextAlign.center),
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
                final workername = documentSnapshot['workername'];
                final workerphone = documentSnapshot['workerphone'];
                final status = documentSnapshot['status'];
                final username = documentSnapshot['username'];
                final userphone = documentSnapshot['userphone'];
                final useremail = documentSnapshot['useremail'];
                final date = documentSnapshot['date'];
                final addcosts = documentSnapshot['additional_costs'];
                final blah1 = documentSnapshot['cost_of_labour'];
                final total = documentSnapshot['totalrate'];
                final blah = total.toString();
                // int costlb = int.parse(blah1);
                final blah2 = addcosts.toString();
                final id = documentSnapshot.id;



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
                            key: cardA,
                            title: Text("Worker Name : $workername \nWorker Phone No: $workerphone ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                            subtitle: Text("Total Amount Payable : \u{20B9} $blah \nDate : $date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
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
                                    "Cost of Labour : \u{20B9} $blah1 \nAdditional Costs : \u{20B9} $blah2 \nTotal Cost: \u{20B9} $blah",
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
                                    color: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0)),
                                    onPressed: () {
                                      // openCheckout(total,username,useremail);
                                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>PaymentsPage(workername,workerphone,username,useremail,date,blah,blah1,blah2,id,userphone)));

                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Icon(Icons.currency_rupee),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                                        ),
                                        Text('Make Payment'),
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
  // @override
  // void initState() {
  //   super.initState();
  //   _razorpay = Razorpay();
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //   _razorpay.clear();
  // }
  //
  // void openCheckout(total,username,useremail) async {
  //   var options = {
  //     'key': 'rzp_test_qllQeVROMv1n4B',
  //     'amount': total,
  //     'name': username,
  //     'description': 'HomeCare',
  //     'retry': {'enabled': true, 'max_count': 1},
  //     'send_sms_hash': true,
  //     'prefill': {'contact': '9149900160', 'email': useremail},
  //     'external': {
  //       'wallets': ['paytm']
  //     }
  //   };
  //
  //   try {
  //     _razorpay.open(options);
  //   } catch (e) {
  //     debugPrint('Error: e');
  //   }
  // }
  //
  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   print('Success Response: $response');
  //   /*Fluttertoast.showToast(
  //       msg: "SUCCESS: " + response.paymentId!,
  //       toastLength: Toast.LENGTH_SHORT); */
  // }
  //
  // void _handlePaymentError(PaymentFailureResponse response) {
  //   print('Error Response: $response');
  //   /* Fluttertoast.showToast(
  //       msg: "ERROR: " + response.code.toString() + " - " + response.message!,
  //       toastLength: Toast.LENGTH_SHORT); */
  // }
  //
  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   print('External SDK Response: $response');
  //   /* Fluttertoast.showToast(
  //       msg: "EXTERNAL_WALLET: " + response.walletName!,
  //       toastLength: Toast.LENGTH_SHORT); */
  // }
}
