import 'dart:async';
//import 'dart:js';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_faceid3/routes.dart';

import 'login_page.dart';



class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);


  final String title;
  static String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();


}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;
  List<Map<String,String>> splashData=[];

  _SplashScreenState(){


    //set duration for splash screen which will be shown before the Login page
    new Timer(const Duration(milliseconds: 5000),(){
      setState(() {

        Navigator.of(context).pushAndRemoveUntil(
           MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
      });
    });

    // showing fade effect and navigating to Login page
    new Timer(
        Duration(milliseconds: 10),(){
      setState(() {
        _isVisible = true;
      });
    }
    );

  }


  @override
  Widget build(BuildContext context) {
   return Container(


     decoration: new BoxDecoration(
       gradient: new LinearGradient(
         colors: [Theme.of(context).accentColor, Theme.of(context).primaryColor],
         begin: const FractionalOffset(0, 0),
         end: const FractionalOffset(1.0, 0.0),
         stops: [0.0, 1.0],
         tileMode: TileMode.clamp,
       ),
     ),
     child: AnimatedOpacity(
       opacity: _isVisible ? 1.0 : 0,
       duration: Duration(milliseconds: 1200),
       child: Center(
         child: Container(
           height: 140.0,
           width: 140.0,
           child: Center(

             child: ClipOval(

               child: Icon(Icons.house_sharp, size: 128,),

             ),
           ),
           decoration: BoxDecoration(
               shape: BoxShape.circle,
               color: Colors.white,
               boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.3),
                   blurRadius: 2.0,
                   offset: Offset(5.0, 3.0),
                   spreadRadius: 2.0,
                 )
               ]
           ),
         ),
       ),
     ),

   );

  }


 }


