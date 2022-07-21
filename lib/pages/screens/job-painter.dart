import 'package:HOMECARE/pages/userscreens/pendingrequests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/theme_helper.dart';
import '../../common/userdrawer.dart';
import '../widgets/header_widget.dart';

class Painting extends StatefulWidget {
  const Painting({Key? key}) : super(key: key);

  @override
  _PaintingState createState() => _PaintingState();
}

class _PaintingState extends State<Painting> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController work = new TextEditingController();
  TextEditingController note = new TextEditingController();
  TextEditingController address = new TextEditingController();
  late String txtaddress,txtnote='', worktype='',
      workrequest;
  String date = '${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year} ';
  String time = '${DateTime.now().hour}:${DateTime.now().minute }';
  final User? _user = FirebaseAuth.instance.currentUser;

  double _headerHeight = 100;
  String? userPhone;
  String? userName;
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['email'] == _user?.email) {
          setState(() {
            userPhone = doc['phone'];
            userName = doc['name'];
          });
        }
      });
    });
  }
  Widget build(BuildContext context) {
    double _headerHeight = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Painter Services'),
      ),
      body: Container(
        color: Colors.grey,
        child: Column(
          children: <Widget>[
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, false, Icons.ac_unit), //let's create a common header widget
            ),
            SizedBox(height: 20),
            Flexible(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                // elevation: 2.0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  //constraints: BoxConstraints(minHeight: 260),
                  width: double.infinity,
                  // padding: EdgeInsets.all(1.0),
                  child: Form(

                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: SingleChildScrollView(
                      child: Column(

                        children: <Widget>[

                          ClipRRect(
                            borderRadius: BorderRadius.circular(15), // Image border
                            // child: Image.network('https://c.tenor.com/xtfyT5uZdIwAAAAS/naperville-auto-repair-service-auto-body-repair-naperville.gif', fit: BoxFit.cover),
                            child: Image.asset('assets/images/painter.jpg', fit: BoxFit.cover,
                              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                return child;
                              },

                              // loadingBuilder: (context, child, loadingProgress) {
                              //   if (loadingProgress == null) {
                              //     return child;
                              //   } else {
                              //     return Center(
                              //       child: CircularProgressIndicator(),
                              //     );
                              //   };}

                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text("HomeCare provides skilled and reliable painters that provide quality workmanship at cost you can easily afford. HomeCare offers a comprehensive range of painting services.", style: TextStyle(fontSize: 20),),
                          SizedBox(height: 20.0),


                          TextFormField(
                            controller: work,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Work Description',
                              hintText: 'Work Description',

                            ),
                            onSaved: (value) {
                              workrequest = value!;
                            },
                            validator: (val){
                              if (val!.length == 0) {
                                return "Can't be empty";
                              }
                              if(!(val.isEmpty) && !RegExp(r"(\b((?!=|\,|\.).)+(.)\b)").hasMatch(val)){
                                return "Can't be Empty";
                              }
                              return null;
                            },
                            maxLines: 4,
                            keyboardType: TextInputType.multiline,

                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: address,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Address',
                              hintText: 'Address',

                            ),
                            onSaved: (value) {
                              txtaddress = value!;
                            },
                            validator: (val){
                              if (val!.length == 0) {
                                return "Address cannot be empty";
                              }
                              // if(!(val.isEmpty) && !RegExp(r"(^[a-zA-Z][a-zA-Z\s]{0,20}[a-zA-Z]$)").hasMatch(val)){
                              //   return "Enter a valid Address";
                              // }
                              return null;
                            },
                            maxLines: 1,
                            keyboardType: TextInputType.multiline,

                          ),
                          SizedBox(height: 20.0),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'Work Type',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.black)),
                              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return "Please Select One";
                              }
                            },
                            value: worktype.isNotEmpty ? worktype : null,
                            items: <String>['External Painting', 'Internal Painting']
                                .map<DropdownMenuItem<String>>((String value)
                            {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),);
                            }).toList(),
                            onChanged: (value){
                              setState(() {
                                worktype = value.toString();
                              });
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: note,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Note',
                              hintText: 'any specific instructions, like equipments to be brought.\n(Not Mandatory)',

                            ),
                            onSaved: (value) {
                              if (value!.length == 0) {
                                txtnote = 'None';
                              } else {
                                txtnote = value;
                              }
                            },
                            maxLines: 4,
                            keyboardType: TextInputType.multiline,

                          ),
                          // SizedBox(height: 20.0),
                          // DropdownButtonFormField(
                          //   decoration: InputDecoration(
                          //     labelText: 'Duration',
                          //     fillColor: Colors.white,
                          //     filled: true,
                          //     contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          //     focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.black)),
                          //     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.black)),
                          //     errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                          //     focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                          //   ),
                          //   validator: (value) {
                          //     if (value == null) {
                          //       return "Please Select One";
                          //     }
                          //   },
                          //   value: duration.isNotEmpty ? duration : null,
                          //   items: <String>['0-6 Hrs', '6-12 Hrs', '1-day', '2-day', '3-day', '4-day', '5-day', '6-day', '7-day']
                          //       .map<DropdownMenuItem<String>>((String value)
                          //   {
                          //     return DropdownMenuItem<String>(
                          //       value: value,
                          //       child: Text(value),);
                          //   }).toList(),
                          //   onChanged: (value){
                          //     setState(() {
                          //       duration = value.toString();
                          //     });
                          //   },
                          // ),
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


                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          //LocationInput(_selectPlace),


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: UserDrawer(),
    );
  }
  void submit() async {
    try {

      FirebaseFirestore.instance.collection('workrequests').doc().set({
        "username" : _user?.email,
        "useruid":_user?.uid,
        "work_request" : workrequest,
        "Date" : date +' '+time,
        "address" : txtaddress,
        "work" : "Painter",
        "status" : "Pending",
        "worktype": worktype,
        "instructions": txtnote,
        "user_phone_number": userPhone,
        "userName" : userName,
        // "duration": duration
      });
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>PendingRequests()));
    } catch(e){
      print(e.toString());
    }
  }
}
