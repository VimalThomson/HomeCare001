import 'package:HOMECARE/pages/adminpage.dart';
import 'package:HOMECARE/pages/adminscreens/viewworkers.dart';
import 'package:HOMECARE/pages/userhome.dart';
import 'package:HOMECARE/pages/userscreens/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../pages/adminscreens/viewcomplaints.dart';
import '../pages/adminscreens/viewusers.dart';
import '../pages/adminscreens/workerrequests.dart';
import '../pages/login_page.dart';
import '../pages/services/usermanagement.dart';

class AdminDrawer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: HexColor('#FDECECFF'),
      child: Column(
        children: <Widget>[


          AppBar(
            title: Text('HomeCare '),
            backgroundColor:Colors.white,
            // backgroundColor: HexColor('#FDECECFF'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>AdminPage()));

            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('View Users'),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>ViewUsers()));

            },
          ),

          ListTile(
              leading: Icon(Icons.work),
              title: Text('View Workers'),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>ViewWorkers()));

              }
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Worker Requests'),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>WorkerRequests()));

            },
          ),

          ListTile(
              leading: Icon(Icons.report_problem_outlined),
              title: Text('View Complaints'),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>ViewComplaints()));
              }
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('LogOut'),
            onTap: () {
              UserManagement().signOut();
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> LoginPage()));
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
                  ModalRoute.withName('/')
              );

            },
          ),
        ],
      ),
    );
  }
}
