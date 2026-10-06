import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class PrimaryButton extends StatelessWidget{

  final String title;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const PrimaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.width,
    this.height,
  });
  
  @override
  Widget build(BuildContext context) {

    final double buttonWidth = width ?? MediaQuery.of(context).size.width / 2;
    final double buttonHeight = height ?? 60.h;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(buttonWidth, buttonHeight),
        backgroundColor: AppColors.primary,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide(width: 1.2, color: AppColors.primary),
        ),
      ),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 14.h,
          color: AppColors.primaryBackground,
          fontWeight: FontWeight.w500,
          wordSpacing: 1.2.w
        ),
      ),
    );
  }
}