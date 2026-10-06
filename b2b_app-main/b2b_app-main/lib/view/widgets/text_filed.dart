import 'package:b2b_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFiled extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final void Function(String)? onSubmitted; // <-- ajouté ici
  final double height;
  const CustomTextFiled({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.onSubmitted, 
    this.readOnly = false,
    this.height =50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      height: height.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColors.textColor,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            size: 24.h,
            color: AppColors.primary,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: AppColors.lightGreyTextColor,
            fontStyle: FontStyle.italic,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: onSubmitted, 
      ),
    );
  }
}
