import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class UserInfo extends StatefulWidget {


  String name, address, email, status,pic,phone,id;
  UserInfo( this.name, this.address, this.email, this.status,this.pic,this.phone,this.id);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        title:Text("User Details Page"),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(

              children: [
                SizedBox(height: 120),
                Container(


                  // color: HexColor('#FDECECFF'),
                  width: 400,
                  color: Colors.black,
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
                      child: Text('Phone Number : ${widget.phone}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),),
                    ),
                    SizedBox(height: 10,),


                    SizedBox(
                      width: 320,
                      child: Row(

                        children: [
                          Expanded(
                              child: ElevatedButton(

                                  onPressed: () {
                                    block(widget.id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.redAccent,

                                  ),

                                  child: Text("Block", style: TextStyle(color: Colors.white),)
                              )
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                              child: ElevatedButton(

                                  onPressed: () {
                                    unblock(widget.id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blueAccent,

                                  ),
                                  // color: Colors.white,

                                  child: Text("UnBlock", style: TextStyle(color: Colors.black),)
                              )
                          ),
                        ],
                      ),
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

  void block(id) async {
    try {

      FirebaseFirestore.instance.collection('users').doc(id).update({
        "status" : 'Blocked',
      });
      Fluttertoast.showToast(msg: "The user has been successfully Blocked");
    } catch(e){}
  }



  void unblock(id) async {
    try {

      FirebaseFirestore.instance.collection('users').doc(id).update({
        "status" : 'Online',
      });
      Fluttertoast.showToast(msg: "The user has been successfully Unblocked");
    } catch(e){}
  }
}
