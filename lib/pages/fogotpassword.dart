import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';



class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {

  final _formkey = GlobalKey<FormState>();
  //String email;
  String email = '';
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor('#651BD2'),
        title: Text('Reset Password'),),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formkey,
            child: Column(
              children: [
                Image.asset("assets/images/reset.png"),
                SizedBox(height: 20),
                Text("Enter the Registered Email :",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),

                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Email'
                    ),
                    onChanged: (value) {
                      setState(() {
                        email = value.trim();
                      });
                    },
                    validator: (email) {
                      if(!(email!.isEmpty) && !RegExp(r"^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$").hasMatch(email)){
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      child: Text('Send Request'),
                      onPressed: () {
                        try {
                          if(_formkey.currentState!.validate()){
                            _formkey.currentState!.save();
                            auth.sendPasswordResetEmail(email: email);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Link has successfully sent"),
                              duration: Duration(milliseconds: 300),
                            ));
                            Navigator.of(context).pop();
                          }
                        } on FirebaseAuthException catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(e.toString()),
                            duration: Duration(milliseconds: 300),
                          ));
                        }
                      },
                    ),
                  ],
                ),
              ],),
          ),
        ),
      ),
    );
  }
}