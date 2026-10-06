import 'dart:async';
import 'package:deliveryapp/view/screen/start_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
     const   Duration(seconds: 4),
       () => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child:  StartScreen(),
            );
          },
          transitionDuration: const Duration(seconds: 1),
        ),
      ),
            );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.third],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter
        ),),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
              const  SizedBox(height: 10,),
                Center(
                  child: Image.asset(
                    "assets/images/applogo.png",
                    height: 300.0,
                    width: 250.0,
                  ),
                ),
              const  SizedBox(height: 20,),
                const Text(" Welcome ",textAlign:TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),

            const CircularProgressIndicator( 
              valueColor:  AlwaysStoppedAnimation<Color>(AppColors.white),
            ),
          ],
        ),
      ),
  
    );
  }
}