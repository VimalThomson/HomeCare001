
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
class VerifyWorkers extends StatefulWidget {


  String name, address, email, pro, status,pic,phone,age,id,aadhar;
  VerifyWorkers( this.name, this.address, this.email, this.pic, this.pro,this.status,this.phone,this.age,this.id,this.aadhar);

  @override
  State<VerifyWorkers> createState() => _VerifyWorkersState();
}

class _VerifyWorkersState extends State<VerifyWorkers> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:Text("Worker Details Page"),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 120),
                Container(

                  // color: HexColor('#FDECECFF'),
                  color: Colors.black,
                  width: 400,
                  child: Column (children: [
                    SizedBox(height: 15),
                    Container(
                      width: 350,

                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(widget.pic),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width:320,
                      alignment: Alignment.centerLeft,
                      child: Text('Name : ${widget.name}', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, color: Colors.white),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 320,
                      alignment: Alignment.centerLeft,
                      child: Text('Address : ${widget.address}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),),
                    ),SizedBox(height: 10,),
                    Container(
                      width: 320,
                      alignment: Alignment.centerLeft,
                      child: Text('Email : ${widget.email}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 320,
                      alignment: Alignment.centerLeft,
                      child: Text('Age : ${widget.age}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 320,
                      alignment: Alignment.centerLeft,
                      child: Text('Status : ${widget.status}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 320,
                      alignment: Alignment.centerLeft,
                      child: Text('Profession : ${widget.pro}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 320,
                      alignment: Alignment.centerLeft,
                      child: Text('Phone Number : ${widget.phone}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 320,
                      alignment: Alignment.centerLeft,
                      child: Text('Aadhar No : ${widget.aadhar}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),),
                    ),
                    SizedBox(height: 10,),


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
                            verify(widget.id);

                            sendverificationmail();

                          },
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.check),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text('Verify'),
                            ],
                          ),
                        ),
                        FlatButton(
                          minWidth: 150,
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          onPressed: () {
                            reject(widget.id);
                            sendrejectionmail();
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.cancel),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text('Reject'),
                            ],
                          ),
                        ),
                      ],
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

  void verify(id) async {
    try {

      FirebaseFirestore.instance.collection('users').doc(id).update({
        "status" : 'Online',
        "role" : 'Worker',
      });
      Fluttertoast.showToast(msg: "The user has been successfully Verified");
    } catch(e){}
  }
  void reject(id) async {
    try {

      FirebaseFirestore.instance.collection('users').doc(id).update({
        "status" : 'Rejected',
        "role" : "Blah",
      });

      Fluttertoast.showToast(msg: "The user has been successfully Verified");
    } catch(e){}
  }
  Future<void> sendverificationmail() async {
    final Email mail = Email(
      body: "Sir/Mam your account has been successfully verified, you can login to your account using your credentials. \n \n \n \nWith Regards, \nTeam HomeCare",
      subject: 'Verification Completed',
      recipients: ["${widget.email}"],
      // attachmentPaths: attachments,
      isHTML: false,
    );
    try {
      await FlutterEmailSender.send(mail);


    } catch (error) {
      print(error.toString());
    }

  }
  Future<void> sendrejectionmail() async {
    final Email mail = Email(
      body: "Sir/Mam your application has been rejected. \n \n \n  \nTeam HomeCare",
      subject: 'Verification Completed',
      recipients: ["${widget.email}"],
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
