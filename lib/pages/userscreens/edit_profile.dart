import 'package:HOMECARE/pages/userscreens/profile_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../common/theme_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();




  late String txtname ,txtplace;



  final dbRef = FirebaseDatabase.instance.ref().child('users');
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('users');
  final _auth = FirebaseAuth.instance;
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  final User? _user = FirebaseAuth.instance.currentUser;
 late String? userName= 'null',userPlace= 'null';

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
            userName = doc['name'];
            userPlace = doc['place'];
          });
        }
      });
    });

  }


  Widget build(BuildContext context) {
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Update Profile",textAlign: TextAlign.center),

      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
            children: [
              SizedBox(height: 180,),
              Container(
                child: Text("Update you details.",style: TextStyle(fontSize: 35,),),
              ),
              Container(
                // margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
                // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Form(
                      //autovalidate: true,
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: Column(
                        children: [

                          SizedBox(height: 110,),
                          Container(
                            child: TextFormField(
                              initialValue: "$userName",
                              // controller: fname,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Name', 'Enter your name'),
                              onSaved: (value) {
                                txtname = value!;
                              },
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                if (val == null) {
                                  return "Can't be Empty";
                                }
                               else if (!RegExp(
                                    r"(^[a-zA-Z][a-zA-Z\s]{0,20}[a-zA-Z]$)")
                                    .hasMatch(val)) {
                                  return "Enter a valid Name";
                                }
                                return null;
                              },
                            ),
                            decoration: ThemeHelper()
                                .inputBoxDecorationShaddow(),
                          ),



                          SizedBox(height: 20.0),
                          Container(
                            child: TextFormField(
                              initialValue: "$userPlace",
                              // controller: place,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Address', 'Enter your Address'),
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                txtplace = value!;
                              },
                              validator: (val) {
                                if (val == null) {
                                  return "Can't be Empty";
                                }
                                // else if (!RegExp(
                                //     r"(^[a-zA-Z][a-zA-Z\s]{0,20}[a-zA-Z]$)")
                                //     .hasMatch(val)) {
                                //   return "Enter a valid Address";
                                // }
                                // return null;
                              },
                            ),
                            decoration: ThemeHelper()
                                .inputBoxDecorationShaddow(),
                          ),

                          SizedBox(height: 20.0),
                          Container(

                            decoration: ThemeHelper().buttonBoxDecoration(
                                context),
                            child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      40, 10, 40, 10),
                                  child: Text(
                                    "Update".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    update();
                                  }
                                  // print(uplace);

                                }

                              // },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],


      ),
    );
  }
  void update() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        "name" : txtname,
        "place" : txtplace,
      });
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>ProfileView()));
    } catch(e){}
  }



}


