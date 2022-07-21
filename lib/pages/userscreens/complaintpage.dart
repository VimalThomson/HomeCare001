import 'package:HOMECARE/pages/userscreens/ongoingworks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../common/admindrawer.dart';
import '../../common/theme_helper.dart';
class Complaint extends StatefulWidget {


  String workername, workeremail, work;
  Complaint( this.workername, this.workeremail, this.work);

  @override
  State<Complaint> createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  final _formKey = GlobalKey<FormState>();
  final User? _user = FirebaseAuth.instance.currentUser;
  // DateTime? _chosenDateTime;
  DateTime date = DateTime(2016, 10, 26);
  DateTime time = DateTime(2016, 5, 10, 22, 35);
  DateTime dateTime = DateTime(2016, 8, 3, 17, 45);
  // late String datee = DateTime.now() as String ;
  late String dateee = '${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year}';

  TextEditingController txtcomplaint = new TextEditingController();
  late String
      complaint;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        title:Text("User Details Page"),
      ),
      body:  SingleChildScrollView(
            child: Column(

              children: [
                SizedBox(height: 80),
                Container(
                width: 400,


                  child: Column (children: [
                    SizedBox(height: 15),

                    SizedBox(height: 20,),
                    Container(
                      width:320,
                      alignment: Alignment.centerLeft,
                      child: Text('Worker Name : ${widget.workername}', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, color: Colors.black),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 320,
                      alignment: Alignment.centerLeft,
                      child: Text('Worker Email : ${widget.workeremail}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.black),),
                    ),SizedBox(height: 10,),
                    Container(
                      width: 320,
                      alignment: Alignment.centerLeft,
                      child: Text('Worker Profession : ${widget.work}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.black),),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.80,
                      //constraints: BoxConstraints(minHeight: 260),
                      width: double.infinity,
                      // padding: EdgeInsets.all(1.0),
                      child: Form(
                        autovalidateMode: AutovalidateMode.always,
                        key: _formKey,

                        // key: _formKey,
                        child:Column(

                            children: <Widget>[

                              SizedBox(height: 20.0),
                              Container(
                                height: 200,
                                child: CupertinoDatePicker(


                                    mode: CupertinoDatePickerMode.date,

                                    initialDateTime: DateTime.now(),
                                    maximumDate: DateTime.now(),
                                    minimumYear: 2021,
                                    maximumYear: 2022,
                                    // use24hFormat: false,

                                    onDateTimeChanged: (DateTime newDate) {
                                      setState(() => date = newDate);
                                      dateee = '${date.month}-${date.day}-${date.year}';
                                    }
                                ),
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                controller: txtcomplaint,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Complaint',
                                  hintText: 'Describe the Problem',

                                ),
                                onSaved: (value) {
                                  complaint = value!;
                                },
                                validator: (val){
                                  if (val!.length == 0) {
                                    return "Can't be Empty";
                                  }
                                  if(!RegExp(r"(\b((?!=|\,|\.).)+(.)\b)").hasMatch(val)){
                                    return "Enter a valid Complaint";
                                  }
                                  return null;
                                },
                                maxLines: 4,
                                keyboardType: TextInputType.multiline,

                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text('Submit'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                  ),
                                  onPressed: (){
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      submit();
                                    }
                                    Fluttertoast.showToast(
                                      msg: "Complaint has been successfully registered",
                                    );
                                    // print(widget.workeremail);
                                  },
                                ),
                              ),
                              SizedBox(height: 10,)
                            ],
                          ),

                      ),
                    ),
                  ],
                  ),
                ),

              ],
            ),),
    );
  }
  void submit() async {
    try {

      FirebaseFirestore.instance.collection('complaints').doc().set({
        "username" : _user?.email,
        "Worker_Name" : widget.workername,
        "worker_email" : widget.workeremail,
        "worker_profession": widget.work,
        "Date" : dateee,
        "Complaint" : complaint
      });

      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>OngoingWorks()));
      // Fluttertoast.showToast(msg: "Complaint has been succesfully registered");
    } catch(e){
      print(e.toString());

    }
  }
}
