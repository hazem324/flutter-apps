import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class SecondButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;

  const SecondButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = width ?? MediaQuery.of(context).size.width;
    final double buttonHeight = height ?? 45.h;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(buttonWidth, buttonHeight),
        backgroundColor: backgroundColor ?? Colors.white,
        foregroundColor: textColor ?? AppColors.primary,
        elevation: 0,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(width: 1.2, color: textColor ?? AppColors.primary),
        ),
      ),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 14.h,
          color: textColor ?? AppColors.primary,
          fontWeight: FontWeight.w500,
          wordSpacing: 1.2.w,
        ),
      ),
    );
  }
}
