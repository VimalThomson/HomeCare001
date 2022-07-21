import 'package:HOMECARE/pages/fogotpassword.dart';
import 'package:HOMECARE/pages/userhome.dart';
import 'package:HOMECARE/pages/adminpage.dart';
import 'package:HOMECARE/pages/userprofile.dart';
import 'package:HOMECARE/pages/workerhome.dart';
import 'package:HOMECARE/pages/workerprofilescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:HOMECARE/common/theme_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/loading.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';

class EmailFieldValidator {
  static String? validate(String value) {
    if (value!.length == 0) {
      return "Email cannot be empty";
    }
    if (!RegExp(
        r"^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$")
        .hasMatch(value)) {
      return ("Please enter a valid email");
    }else {
      return null;
    }
  }
}

class PasswordFieldValidator {
  static String? validate(String value) {
    RegExp regex = new RegExp(r'^.{6,}$');
    if (value!.isEmpty) {
      return "Password cannot be empty";
    }
    if (!regex.hasMatch(value)) {
      return ("please enter valid password min. 6 character");
    }else {
      return null;
    }
  }
}


class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  bool visible = false;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  //Firebase

  final _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.ref().child('users');
  final fire = FirebaseFirestore.instance.collection('users');
  String role = 'user';
  String status = 'Online';


  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.home), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  // This will be the login form
                  child: Column(
                    children: [
                      Image.asset('assets/images/logo1.jpg'),
                      SizedBox(height: 100.0),
                      Form(
                          autovalidateMode: AutovalidateMode.always,
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  controller: email,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Email', 'Enter your Email'),

                                  // validator: (value) {
                                  //   if (value!.length == 0) {
                                  //     return "Email cannot be empty";
                                  //   }
                                  //   if (!RegExp(
                                  //       r"^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$")
                                  //       .hasMatch(value)) {
                                  //     return ("Please enter a valid email");
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                  validator:(value)=> EmailFieldValidator.validate(value!),

                                  onSaved: (value) {
                                    email.text = value!;
                                  },
                                ),

                                decoration: ThemeHelper()
                                    .inputBoxDecorationShaddow(),

                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextFormField(
                                  controller: password,
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Password', 'Enter your password'),
                                  // validator: (value) {
                                  //   RegExp regex = new RegExp(r'^.{6,}$');
                                  //   if (value!.isEmpty) {
                                  //     return "Password cannot be empty";
                                  //   }
                                  //   if (!regex.hasMatch(value)) {
                                  //     return ("please enter valid password min. 6 character");
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                  validator:(value)=> PasswordFieldValidator.validate(value!),

                                  onSaved: (value) {
                                    password.text = value!;
                                  },
                                ),

                                decoration: ThemeHelper()
                                    .inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),

                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(
                                    context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text('Sign In'.toUpperCase(),
                                      style: TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),),
                                  ),
                                  onPressed: () {
                                    setState(()  {

                                      visible = true;
                                    });
                                    signIn(
                                        email.text, password.text);
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 5),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Forgot Password?',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ResetScreen()));
                                              },
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Theme
                                                    .of(context)
                                                    .accentColor),
                                          ),
                                        ]
                                    )
                                ),
                              ),
                              SizedBox(height: 0.0),
                              Container(

                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "Don\'t have an account? "),
                                          TextSpan(
                                            text: 'Create',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegistrationPage()));
                                              },
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Theme
                                                    .of(context)
                                                    .accentColor),
                                          ),
                                        ]
                                    )
                                ),
                              ),


                            ],
                          )
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
void signIn(String email, String password) async {
  if (_formKey.currentState!.validate()) {
    setState(()=>loading = true);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
        User? user = FirebaseAuth.instance.currentUser;
        final DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
        setState(() {
          role = snap['role'];
          status = snap['status'];
          setState(() => loading = true);
        });
        if(status == 'Online'){
          if(role == 'User'){
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => Userhome()));
          }
          else if(role == 'Admin'){
            Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> AdminPage()));
          } else if(role == 'Worker') {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => WorkerHome()));
          }
        }else if(status == 'Offline'){

          if(role == 'User'){
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => UserProfileScreen()));
          } else if(role == 'Worker') {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => WorkerProfileScreen1()));
          }
        }
        else if(status == 'Verification Pending'){
          loading = false;

          Fluttertoast.showToast(
            msg: "Verification not complete yet, please wait",
          );

        }
        else if(role == 'Blah'){
          loading = false;
          Fluttertoast.showToast(
            msg: "Your application has been rejected.",
          );
        }
        else{
          loading = false;
          Fluttertoast.showToast(
            msg: "You don't have authorization to Login",
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });
      if (e.code == 'user-not-found') {
        print("No user found with this email");

        Fluttertoast.showToast(
          msg: "No user found with this email",
        );
      } else if (e.code == 'wrong-password') {
        print("You have entered the Wrong Password");

        Fluttertoast.showToast(
          msg: "You have entered the Wrong Password",
        );
      }
    }
  }else {
    loading = false;
  }
}

}
