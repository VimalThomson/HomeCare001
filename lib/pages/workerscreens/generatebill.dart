import 'package:HOMECARE/pages/workerhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import '../../common/theme_helper.dart';
class GenerateBill extends StatefulWidget {


  String workername,workeremail,workerphone,docid,useruid,userName,id,username,userphone;
  GenerateBill( this.workername, this.workeremail, this.workerphone,this.docid,this.useruid,this.userName,this.id,this.username,this.userphone);

  @override
  State<GenerateBill> createState() => _GenerateBillState();
}

class _GenerateBillState extends State<GenerateBill> {
  late String date = '${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year}';
  TextEditingController worktime = new TextEditingController();
  TextEditingController othercosts = new TextEditingController();

  late String txttotalrate='', txtothercosts='';
  var totalcosts,equiprate;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        title:Text("Generate Bill"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(

          child: Column(
            children: [

              SizedBox(height: 150),
              Container(
                color: Colors.white,
                width: 400,

                // margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
                // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(height: 50.0,),
                    Center(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text('Generate Bill',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Form(
                      //autovalidate: true,
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: Column(
                        children: [


                          SizedBox(height: 20.0),
                          Container(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: worktime,
                                  // obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "Total work time(in hrs)", "type 0 if less than 1hr"),
                                  onSaved: (value) {
                                    var rate = int.parse(value!);
                                    if(rate < 1 ){
                                      txttotalrate = "300";
                                    }else if(rate > 1){
                                      int blah = rate * 100 ;
                                      int totalrate = blah+300;
                                      txttotalrate=totalrate.toString();
                                    }
                                  },
                                  validator: (val) {
                                    if (val!.length == 0) {
                                      return "cannot be empty";
                                    }
                                    if(!RegExp(r"^[0-9]{1,2}$").hasMatch(val)){
                                      return " ";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20,),
                                TextFormField(
                                  controller: othercosts,
                                  // obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "Other Costs", "Other misc costs(0 if no extra costs)"),
                                  onSaved: (value) {
                                    equiprate = int.parse(value!);
                                    if(equiprate == 0){
                                      totalcosts = txttotalrate;
                                    }else if (equiprate >= 1){
                                      int blah1 = int.parse(txttotalrate);
                                     totalcosts = blah1+equiprate;


                                    }
                                  },
                                  validator: (val) {
                                    if (val!.length == 0) {
                                      return "cannot be empty";
                                    }
                                  },
                                ),
                              ],
                            ),
                            decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 15.0),

                          SizedBox(height: 20.0),
                          ButtonBar(
                            alignment: MainAxisAlignment.spaceAround,
                            buttonHeight: 52.0,
                            buttonMinWidth: 90.0,
                            children: <Widget>[
                              FlatButton(
                                minWidth: 320,
                                color: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0)),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    generateBill();
                                    emailbill();

                                    // print(txttotalrate);
                                  }
                                },
                                child: Column(
                                  children: <Widget>[

                                    Text('Generate Bill', style: TextStyle(fontSize:16),),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 50,),

                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  void generateBill() async {
    try {

      FirebaseFirestore.instance.collection('payment').doc(widget.docid).set({
        "useruid": widget.useruid,
        "useremail": widget.username,
        "username": widget.userName,
        "workeruid": widget.id,
        "workername": widget.workername,
        "workeremail": widget.workeremail,
        "workerphone": widget.workerphone,
        "cost_of_labour": txttotalrate,
        "userphone":widget.userphone,
        "totalrate": totalcosts,
        "date": date,
        "additional_costs": equiprate,
        "status":"Pending"
      });
      FirebaseFirestore.instance.collection('workrequests').doc(widget.docid).update({
        "status":"Payment Pending",
        "cost_of_labour": txttotalrate,
        "additional_costs": equiprate,
        "totalrate": totalcosts,
        "bill_date": date,



      });
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>WorkerHome()));
      Fluttertoast.showToast(msg: "Bill has been successfully generated and sent to the customer");
    } catch(e){
      print(e.toString());
    }
  }
  Future<void> emailbill() async {
    final Email mail = Email(
      body: "Sir/Mam your work has been successfully completed by ${widget.workername}, the total cost of the work is \u{20B9} ${totalcosts}, in which labour expense is \u{20B9} ${txttotalrate} and the cost of other equipments, instruments and other misc costs is \u{20B9} ${equiprate}. \nKindly login to you HomeCare app and complete the payment. \n \n \nTeam HomeCare.",
      subject: 'HomeCare Bill',
      recipients: ["${widget.username}"],
      // attachmentPaths: attachments,
      isHTML: false,
    );
    try {
      await FlutterEmailSender.send(mail);


    } catch (error) {
      print(error.toString());
    }

  }
}
