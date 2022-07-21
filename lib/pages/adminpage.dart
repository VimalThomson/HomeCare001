import 'package:HOMECARE/common/admindrawer.dart';
import 'package:HOMECARE/pages/adminscreens/viewcomplaints.dart';
import 'package:HOMECARE/pages/adminscreens/viewworkers.dart';
import 'package:HOMECARE/pages/services/usermanagement.dart';
import 'package:HOMECARE/pages/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'adminscreens/viewusers.dart';
import 'login_page.dart';



class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _headerHeight = 0;
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("HomeCare",textAlign: TextAlign.center),
      ),
      body: SingleChildScrollView(

        child: Container(
          color: HexColor('#FDECECFF'),
          child: Column(
            children: <Widget>[
              // Container(
              //   height: _headerHeight,
              //   child: HeaderWidget(_headerHeight, true, Icons.home), //let's create a common header widget
              // ),

              SizedBox(
                height: 10
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          image: new DecorationImage(
                              image: new AssetImage('assets/images/users.jpg'),
                              fit: BoxFit.contain),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: GestureDetector(onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>ViewUsers(),
                          ),
                        );
                      },    child: null),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          image: new DecorationImage(
                              image: new AssetImage('assets/images/workers.jpg'),
                              fit: BoxFit.contain),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: GestureDetector(onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>ViewWorkers(),
                          ),
                        );
                      },
                      ),
                    )

                  ],
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        image: new DecorationImage(
                            image: new AssetImage('assets/images/Complaints.jpg'),
                            fit: BoxFit.contain),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: GestureDetector(onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>ViewComplaints(),
                        ),
                      );
                    },child: null),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        image: new DecorationImage(
                            image: new AssetImage('assets/images/Logout.jpg'),
                            fit: BoxFit.contain),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: GestureDetector(onTap: () {
                      UserManagement().signOut();
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> LoginPage()));
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
                          ModalRoute.withName('/')
                      );
                    },child: null),
                  ),
                  SizedBox(height: 20,),
                ],
              ),

            ],
          ),
        ),
      ),
      drawer: AdminDrawer(),
    );
  }
}

