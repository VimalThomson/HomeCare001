// //import 'package:final_year_project/providers/users.dart';
// //import 'package:final_year_project/screens/bookings.dart';
// //import 'package:final_year_project/screens/task_screen.dart';
// import 'package:HOMECARE/pages/login_page.dart';
// import 'package:HOMECARE/pages/screens/profile.dart';
// import 'package:HOMECARE/pages/userhome.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:HOMECARE/pages/services/usermanagement.dart';
//
//
// class AppDrawer extends StatelessWidget {
//   @override
//
//   Widget build(BuildContext context) {
//
//     return Drawer(
//       child: Column(
//         children: <Widget>[
//           AppBar(
//             title: Text('HomeCare '),  //(+ name != null ? name : 'Friend'),
//             automaticallyImplyLeading: false,
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.home),
//             title: Text('Home'),
//             onTap: () {
//              // Navigator.of(context).pushReplacementNamed(BookingsScreen.routeName);
//             },
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.book_online),
//             title: Text('Bookings'),
//             onTap: () {
//               // Navigator.of(context).pushReplacementNamed(BookingsScreen.routeName);
//             },
//           ),
//           Divider(),
//           ListTile(
//               leading: Icon(Icons.edit),
//               title: Text('Profile'),
//               onTap: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) =>  (),
//                 //   ),
//                 // );
//                 // Navigator.of(context).pushNamed(EditProfile.routeName );
//                 //Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ProfileCard(authData.userId,authData.token)));
//               }
//           ),
//
//
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.exit_to_app),
//             title: Text('LogOut'),
//             onTap: () {
//               UserManagement().signOut();
//               //Navigator.of(context).popUntil(ModalRoute.withName('login_page'));
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
//                   ModalRoute.withName('/')
//               );
//
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }