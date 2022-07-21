import 'package:HOMECARE/firebase_options.dart';
import 'package:HOMECARE/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';


import 'pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(LoginUiApp());
}

class LoginUiApp extends StatelessWidget {

  Color _primaryColor = HexColor('#0066FF');
  Color _accentColor =  HexColor('#191654');
  //0066FF
  // Color _primaryColor = HexColor('#0F0C29');
  // Color _accentColor =  HexColor('#302B63');

  // Color _primaryColor = HexColor('#0F0C29').withOpacity(0.8);
  // Color _accentColor =  Colors.white;

  //Design color
  // Color _primaryColor= HexColor('#FFC867');
  // Color _accentColor= HexColor('#FF3CBD');

  // Our Logo Color
  // Color _primaryColor= HexColor('#D44CF6');
  // Color _accentColor= HexColor('#5E18C8');

  // Our Logo Blue Color
  // Color _primaryColor= HexColor('#651BD2');
  // Color _accentColor= HexColor('#320181');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homecare',
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,

      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset("assets/images/logo.jpg"),
        splashIconSize: 500,
        nextScreen: LoginPage(),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.white,
        duration: 1500,
      )

    );
  }
}
