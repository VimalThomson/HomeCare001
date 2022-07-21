
import 'package:HOMECARE/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:HOMECARE/common/theme_helper.dart';
import 'package:HOMECARE/pages/widgets/header_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'login_page.dart';




class RegistrationPage extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController fname = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController place = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();

  late String txtname, txtphone, txtemail, txtpassword, txtplace, txtgender='', txtrole='';





  final dbRef = FirebaseDatabase.instance.ref().child('users');
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;

  void register() async {
    try {
      final newUser = _auth.createUserWithEmailAndPassword(
          email: txtemail, password: txtpassword)
          .then((value) {
        FirebaseFirestore.instance.collection('users').doc(value.user?.uid).set(
            {"email": value.user?.email,
              "name": txtname,
              "place": txtplace,
              "phone": txtphone,
              "role": txtrole,
              "age": '',
              "profession": '',
              "aadhar_no": '',
              "status": 'Offline',
              "profilepicURL":'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
              "gender": txtgender});
      },
      );
      if  (newUser != null) {
        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>LoginPage()));
      }
    } catch (e) {
      print (e);
      SnackBar(
        content: Text("Username Already exists"),
        backgroundColor: Colors.teal,
      );
      Fluttertoast.showToast(msg: e.toString());
      print(e);

    }
  }


  // void register() async {
  //   try {
  //     final User? user = await FirebaseAuth.instance.currentUser;
  //     //String? userID = user?.uid;
  //     final newUser = _auth.createUserWithEmailAndPassword(
  //         email: txtemail, password: txtpassword).then((value) {
  //           FirebaseDatabase.instance.ref().child('users').child(value.user!.uid).set(
  //               {
  //                 'email' : value.user?.email,
  //                 'name' : txtname,
  //                 'phone' : txtphone,
  //                 'place' : txtplace,
  //                 'role' : txtrole
  //               });
  //     });
  //
  //     // if (newUser != null) {
  //     //
  //     //   final User? user = await FirebaseAuth.instance.currentUser;
  //     //   String? userID = user?.uid;
  //     //   addUser(userID!);
  //     // }
  //   } catch (e) {
  //     print (e);
  //     Fluttertoast.showToast(msg: e.toString());
  //
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                            controller: fname,
                            decoration: ThemeHelper().textInputDecoration('Name', 'Enter your name'),
                            onSaved: (value) {
                              txtname = value!;
                            },
                            keyboardType: TextInputType.text,
                            validator: (val){
                              if (val!.length == 0) {
                                return "Name cannot be empty";
                              }
                              if(!(val.isEmpty) && !RegExp(r"(^[a-zA-Z][a-zA-Z\s]{0,20}[a-zA-Z]$)").hasMatch(val)){
                                return "Enter a valid Name";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30,),

                        Container(
                          child: TextFormField(
                            controller: email,
                            decoration: ThemeHelper().textInputDecoration("E-mail address", "Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              txtemail = value!;
                            },
                            validator: (value) {
                              if (value!.length == 0) {
                                return "Email cannot be empty";
                              }
                              if (!RegExp(r"^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$")
                                  .hasMatch(value)) {
                                return ("Please enter a valid email");
                              } else {
                                return null;
                              }
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),

                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0), borderSide: BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "Select One";
                            }
                          },
                          value: txtgender.isNotEmpty ? txtgender : null,
                          items: <String>['Male', 'Female','Others']
                              .map<DropdownMenuItem<String>>((String value)
                          {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),);
                          }).toList(),
                          onChanged: (value){
                            setState(() {
                              txtgender = value.toString();
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: place,
                            decoration: ThemeHelper().textInputDecoration('Address', 'Enter your Address'),
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              txtplace = value!;
                            },
                            validator: (val){
                              if (val!.length == 0) {
                                return "Address cannot be empty";
                              }
                            //
                          },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: phone,
                            decoration: ThemeHelper().textInputDecoration(
                                "Mobile Number",
                                "Enter your mobile number"),
                            keyboardType: TextInputType.phone,
                            onSaved: (value) {
                              txtphone = value!;
                            },
                            validator: (val) {
                              if (val!.length == 0) {
                                return "Phone Number cannot be empty";
                              }
                              if(!(val.isEmpty) && !RegExp(r"^[0-9]{10}$").hasMatch(val)){
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: password,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password*", "Enter your password"),
                            onSaved: (value) {
                              txtpassword = value!;
                            },
                            validator: (val) {
                              if (val!.length == 0) {
                                return "Password cannot be empty";
                              }
                              if(!(val.isEmpty) && !RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$").hasMatch(val)){
                                return "Please enter a stronger password";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          child: TextFormField(
                            controller: confirmpassword,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Confirm password*", "Re-enter your password"),
                            validator: (val){
                              if(val!.isEmpty)
                              {
                                return 'Please re-enter password';
                              }
                              print(password.text);
                              print(confirmpassword.text);
                              if(password.text!=confirmpassword.text){
                                return "Password does not match";
                              }

                              return null;
                            },


                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),

                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'SignUp as',
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0), borderSide: BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "Select One";
                            }
                          },
                          value: txtrole.isNotEmpty ? txtrole : null,
                          items: <String>['User', 'Worker']
                            .map<DropdownMenuItem<String>>((String value)
                          {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),);
                          }).toList(),
                          onChanged: (value){
                            setState(() {
                              txtrole = value.toString();
                            });
                          },
                        ),

                        SizedBox(height: 20.0),
                        Container(

                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "SignUp".toUpperCase(),
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
                                register();
                                //register1();
                              }
                              }

                           // },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          margin: EdgeInsets.fromLTRB(10,20,10,20),
                          //child: Text('Don\'t have an account? Create'),
                          child: Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: "Already have an account? "),
                                    TextSpan(
                                      text: 'Login',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                        },
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                    ),
                                  ]
                              )
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
      ),
    );
  }

}