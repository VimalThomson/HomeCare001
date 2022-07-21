import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../userhome.dart';
class PaymentsPage extends StatefulWidget {


  String workername,workerphone,username,useremail,date,blah,blah1,blah2,id,userphone;
  PaymentsPage( this.workername,this.workerphone,this.username,this.useremail,this.date,this.blah,this.blah1,this.blah2,this.id,this.userphone);

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  late Razorpay _razorpay;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        title:Text("Payments "),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(

              children: [
                SizedBox(height: 120),
                Container(


                  // color: HexColor('#FDECECFF'),
                  width: 400,
                  color: Colors.white,
                  child: Column (children: [

                    Container(
                      width: 400,
                      height: 200,

                      alignment: Alignment.center,
                      child: Image.asset('assets/images/logo1.jpg'),
                    ),

                    Container(
                      width:320,
                      alignment: Alignment.centerLeft,
                      child: Text('Worker Name : ${widget.workername}', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, color: Colors.black),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 320,
                      alignment: Alignment.centerLeft,
                      child: Text('Worker Phone No : ${widget.workerphone}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.black),),
                    ),SizedBox(height: 10,),
                    Container(
                      width: 320,
                      alignment: Alignment.centerLeft,
                      child: Text('Date : ${widget.date}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.black),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 320,
                      alignment: Alignment.centerLeft,
                      child: Text('Total Amount Payable : \u{20B9} ${widget.blah}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.black),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 320,
                      alignment: Alignment.centerLeft,
                      child: Text('Total labour Costs : \u{20B9} ${widget.blah1}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.black),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 320,
                      alignment: Alignment.centerLeft,
                      child: Text('Other additional costs : \u{20B9} ${widget.blah2}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.black),),
                    ),
                    SizedBox(height: 10,),


                    SizedBox(
                      width: 320,
                      child: Row(

                        children: [
                          SizedBox(width: 20,),
                          Expanded(
                              child: ElevatedButton(

                                  onPressed: () {
                                    openCheckout(widget.blah,widget.username,widget.useremail,widget.userphone);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blueAccent,

                                  ),
                                  // color: Colors.white,

                                  child: Text("Make Payment", style: TextStyle(color: Colors.black),)
                              )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                  ),
                ),

              ],
            ),)
      ),
      // drawer: AdminDrawer(),

    );
  }
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(blah,username,useremail,userphone) async {
    var options = {
      'key': 'rzp_test_qllQeVROMv1n4B',
      'amount': blah,
      'name': username,
      'description': 'HomeCare Bill',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': userphone, 'email': useremail},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
      print(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
   FirebaseFirestore.instance.collection('payment').doc(widget.id).update({
     "status":"Payment Completed"
   });
   FirebaseFirestore.instance.collection('workrequests').doc(widget.id).update({
     "status":"Completed "
   });
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Userhome()));
    Fluttertoast.showToast(msg: "Payment Successfully completed");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    FirebaseFirestore.instance.collection('test').doc(widget.id).set({
      "blah":"blah"
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }
}
