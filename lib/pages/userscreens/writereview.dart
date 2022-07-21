import 'package:HOMECARE/common/userdrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../common/theme_helper.dart';

class WriteReview extends StatefulWidget {
  const WriteReview( {Key? key}) : super(key: key);

  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  final _formKey = GlobalKey<FormState>();
  final User? _user = FirebaseAuth.instance.currentUser;
  String date = '${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year} ';
  String time = '${DateTime.now().hour}:${DateTime.now().minute }';
  TextEditingController txtreview = new TextEditingController();
  late String Review;
  String? userName;
  String? userPlace;
  String? userPhone;
  String? email;
  String imageUrl = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';


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
            email = doc['email'];
            userName = doc['name'];
            userPlace = doc['place'];
            userPhone = doc['phone'];
            imageUrl = doc['profilepicURL'];
          });
        }
      });
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Review",textAlign: TextAlign.center),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Flexible(
              child: Column(
                children: [
                  SizedBox(height: 150,),
                  Container(
                    child: Text('Write to us.',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  ),
                  Center(
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 250,
                        width: 350,
                        child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          key: _formKey,

                          // key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(

                              children: <Widget>[

                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: txtreview,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Review',
                                    hintText: 'Write a review or feedback',

                                  ),
                                  onSaved: (value) {
                                    Review = value!;
                                  },
                                  validator: (val){
                                    if(!(val!.isEmpty) && !RegExp(r"(\b((?!=|\,|\.).)+(.)\b)").hasMatch(val)){
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

                                        writereview();
                                      }
                                      Fluttertoast.showToast(
                                        msg: "Review has been successfully submitted",
                                      );

                                    },
                                  ),
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
          ],
        ),
      ),
      drawer: UserDrawer(),
    );
  }
  void writereview() async {
    try {

      FirebaseFirestore.instance.collection('reviews').doc().set({
        "useremail" : _user?.email,
        "Date" : date +' '+time,
        "Review" : Review,
        "userName" : userName,
        "userimage" : imageUrl
      });

      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>WriteReview()));
    } catch(e){
      print(e.toString());

    }
  }
}
