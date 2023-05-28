import 'dart:async';

import 'package:flutter/material.dart';
import 'package:texttranslator/Screens/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



Route _createRoute() {
    return PageRouteBuilder(

    barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1, 0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }









 @override
  void initState() {
    
    super.initState();
    Timer(const Duration(seconds: 1,milliseconds: 500),(){
     Navigator.pushReplacement(context,_createRoute());
    });
  }
 
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 15, 15, 15), 
      body: Center(child:Image.asset('assets/images/entry_logo.png',width: 150,height: 150,),),
    );
  }
}