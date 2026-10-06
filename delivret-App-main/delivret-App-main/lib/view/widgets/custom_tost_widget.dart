import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class CustomTostWidget extends StatelessWidget {
final  String ? text;
CustomTostWidget({required this.text});
  @override
  Widget build(BuildContext context) {
     final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width; 
    return Container(
    padding:  EdgeInsets.symmetric(vertical: screenHeight/40.15, horizontal:screenWidth/19.63),
    decoration: BoxDecoration(
       color: const Color.fromRGBO(0, 0, 0, 0.8),
borderRadius: BorderRadius.circular(screenHeight/32.11),
    ),
          child: Text(text!, style:  TextStyle(color: AppColors.white, fontSize: screenHeight/50.25),),
      );
  }

}
