import 'dart:async';
import 'package:b2b_app/utils/app_colors.dart';
import 'package:b2b_app/view/pages/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    slideAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    controller.forward();

    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: LoginPage(),
            );
          },
          transitionDuration: const Duration(seconds: 1),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
         
          final size = MediaQuery.of(context).size;
          final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
          final isLargeScreen = constraints.maxWidth > 600; 

          
          final logoWidth = isLargeScreen
              ? constraints.maxWidth * 0.5
              : constraints.maxWidth * 0.8; 
          final logoHeight = isPortrait
              ? constraints.maxHeight * 0.25 
              : constraints.maxHeight * 0.4; 

          return SafeArea(
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.second.withAlpha(179),
                    AppColors.primary.withAlpha(100),
                  ],
                  stops: [0.0, 1.0], // Ensure smooth gradient across devices
                ),
              ),
              child: Center(
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: SlideTransition(
                    position: slideAnimation,
                    child: Image.asset(
                      "assets/images/logo-t.png",
                      fit: BoxFit.contain, // Use contain to preserve logo aspect ratio
                      width: logoWidth,
                      height: logoHeight,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}