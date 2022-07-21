// import 'package:HOMECARE/common/userdrawer.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import '../../common/theme_helper.dart';
//
// class Complaint extends StatefulWidget {
//   const Complaint( {Key? key}) : super(key: key);
//
//   @override
//   _ComplaintState createState() => _ComplaintState();
// }
// //
// class _ComplaintState extends State<Complaint> {
//   final _formKey = GlobalKey<FormState>();
//   final User? _user = FirebaseAuth.instance.currentUser;
//   // DateTime? _chosenDateTime;
//   DateTime date = DateTime(2016, 10, 26);
//   DateTime time = DateTime(2016, 5, 10, 22, 35);
//   DateTime dateTime = DateTime(2016, 8, 3, 17, 45);
//   late String dateee = '';
//   TextEditingController txtwork = new TextEditingController();
//   TextEditingController txtcomplaint = new TextEditingController();
//   late String workername,
//       complaint;
//
//   void submit() async {
//     try {
//
//       FirebaseFirestore.instance.collection('complaints').doc().set({
//         "username" : _user?.email,
//         "Worker Name" : workername,
//         "Date" : dateee,
//         "Complaint" : complaint
//       });
//
//       Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Complaint()));
//     } catch(e){
//       print(e.toString());
//
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: Text("Register Complaint",textAlign: TextAlign.center),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Column(
//           children: <Widget>[
//             // Container(
//             //   height: _headerHeight,
//             //   child: HeaderWidget(_headerHeight, true, Icons.ac_unit), //let's create a common header widget
//             // ),
//             SizedBox(height: 10),
//             Flexible(
//               child: Card(
//                 color: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 // elevation: 2.0,
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * 0.80,
//                   //constraints: BoxConstraints(minHeight: 260),
//                   width: double.infinity,
//                   // padding: EdgeInsets.all(1.0),
//                   child: Form(
//                     autovalidateMode: AutovalidateMode.always,
//                     key: _formKey,
//
//                     // key: _formKey,
//                     child: SingleChildScrollView(
//                       child: Column(
//
//                         children: <Widget>[
//
//                           SizedBox(height: 50.0),
//                           TextFormField(
//                             controller: txtwork,
//
//                             // decoration: ThemeHelper().textInputDecoration(
//                             //     "Describe the problem*", "Describe the problem"),
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               labelText: 'Complaint Against',
//                               hintText: 'Complaint Against',
//
//
//                             ),
//                             onSaved: (value) {
//                               workername = value!;
//                               },
//
//                             validator: (val){
//                               if(!(val!.isEmpty) && !RegExp(r"(^[a-zA-Z][a-zA-Z\s]{0,20}[a-zA-Z]$)").hasMatch(val)){
//                                 return "Enter a valid Name";
//                               }
//                               return null;
//                             },
//                             maxLines: 1,
//                             keyboardType: TextInputType.multiline,
//
//                           ),
//                           SizedBox(height: 20.0),
//                           Container(
//                             height: 200,
//                             child: CupertinoDatePicker(
//
//                               mode: CupertinoDatePickerMode.date,
//
//                               initialDateTime: DateTime.now(),
//                              maximumDate: DateTime.now(),
//                              minimumYear: 2021,
//                              maximumYear: 2022,
//                              // use24hFormat: false,
//
//                                       onDateTimeChanged: (DateTime newDate) {
//                                         setState(() => date = newDate);
//                                        dateee = '${date.month}-${date.day}-${date.year}';
//                                       }
//                             ),
//                           ),
//                           SizedBox(height: 20.0),
//                           TextFormField(
//                             controller: txtcomplaint,
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               labelText: 'Complaint',
//                               hintText: 'Describe the Problem',
//
//                             ),
//                             onSaved: (value) {
//                               complaint = value!;
//                             },
//                             validator: (val){
//                               if(!(val!.isEmpty) && !RegExp(r"(\b((?!=|\,|\.).)+(.)\b)").hasMatch(val)){
//                                 return "Enter a valid Complaint";
//                               }
//                               return null;
//                             },
//                             maxLines: 4,
//                             keyboardType: TextInputType.multiline,
//
//                           ),
//                           SizedBox(
//                             height: 30,
//                           ),
//                           Container(
//                             decoration: ThemeHelper().buttonBoxDecoration(context),
//                             child: ElevatedButton(
//                               style: ThemeHelper().buttonStyle(),
//                               child: Padding(
//                                 padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
//                                 child: Text('Submit'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
//                               ),
//                               onPressed: (){
//                                 if (_formKey.currentState!.validate()) {
//                                   _formKey.currentState!.save();
//                                   submit();
//                                 }
//                                 Fluttertoast.showToast(
//                                   msg: "Complaint has been successfully registered",
//                                 );
//                                 print(dateee);
//                               },
//                             ),
//                           ),
//                           //LocationInput(_selectPlace),
//
//
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       drawer: UserDrawer(),
//     );
//   }
// }
