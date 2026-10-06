import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

class HeaderContainer extends StatelessWidget {
  final String text;
  

  HeaderContainer({
  
    required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.third],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 10,
              right: 20,
              child: Text(
                text,
                style: GoogleFonts.lato(color: AppColors.white, fontSize: 22, fontWeight: FontWeight.w800)
               )),
          Center(
              child: Image.asset(
            "assets/images/applogo.png",
            height: 180,
            width: 300,
          )),
        ],
      ),
    );
  }
}
