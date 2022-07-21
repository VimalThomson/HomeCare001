import 'dart:math';

import 'package:HOMECARE/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/theme_helper.dart';
import '../../common/userdrawer.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController currentpassword = new TextEditingController();
  TextEditingController newpassword = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();
  late String txtcurrentpassword, txtnewpassword , pass;
  final User? _auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Change Password",textAlign: TextAlign.center),
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
                        child: Text('Change you Password',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Form(
                      //autovalidate: true,
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: Column(
                        children: [

                          SizedBox(height: 20,),
                          // Container(
                          //   child: TextFormField(
                          //     controller: currentpassword,
                          //     obscureText: true,
                          //     decoration: ThemeHelper().textInputDecoration(
                          //         "Password*", "Enter your current password"),
                          //     onSaved: (value) {
                          //       txtcurrentpassword = value!;
                          //     },
                          //     validator: (val) {
                          //       if (val!.length == 0) {
                          //         return "Password cannot be empty";
                          //       }
                          //       if(!(val.isEmpty) && !RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$").hasMatch(val)){
                          //         return "Please enter a stronger password";
                          //       }
                          //       return null;
                          //     },
                          //   ),
                          //   decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          // ),



                          SizedBox(height: 20.0),
                          Container(
                            child: TextFormField(
                              controller: newpassword,
                              obscureText: true,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Enter new Password*", "Enter new password"),
                              onSaved: (value) {
                                txtnewpassword = value!;
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
                                  "Confirm new password*", "Re-enter new password"),
                              validator: (val){
                                if(val!.isEmpty)
                                {
                                  return 'Please re-enter password';
                                }
                                print(newpassword.text);
                                print(confirmpassword.text);
                                if(newpassword.text!=confirmpassword.text){
                                  return "Password does not match";
                                }

                                return null;
                              },


                            ),
                            decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          ),

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
                                    try{
                                      _auth?.updatePassword(txtnewpassword).then((value){
                                        FirebaseAuth.instance.signOut();
                                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>LoginPage()));

                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        backgroundColor: Colors.black,
                                        content: Text("Your password has been Successfully changed."),
                                      ),);
                                    }catch (e){
                                      print(e);
                                    }
                                  }
                                },
                                child: Column(
                                  children: <Widget>[

                                    Text('Change Password', style: TextStyle(fontSize:16),),
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
      // drawer: UserDrawer(),
    );
  }
}
