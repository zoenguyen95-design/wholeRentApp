import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_faceid3/pages/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'dart:ui';

import 'package:project_faceid3/routes.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( LoginUI());
}

class LoginUI extends StatelessWidget {

 Color _primaryColor = HexColor('#fd813e');
 Color _accentColor = HexColor('#eb5402');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter LOGIN',
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor

      ),
      //home:  SplashScreen.routeName,
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
