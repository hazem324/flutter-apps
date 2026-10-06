import 'package:b2b_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPasswordField extends StatefulWidget{

  final String hintText;
final TextEditingController controller;

const CustomPasswordField({
    super.key,
    required this.hintText,
    required this.controller
  });

@override
  CustomPasswordFieldState createState()=> CustomPasswordFieldState();

}

class CustomPasswordFieldState extends State<CustomPasswordField> {

  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline, size: 24.h, color: AppColors.primary),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: widget.controller,
              obscureText: _obscureText,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textColor,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.lightGreyTextColor,
                  fontStyle: FontStyle.italic,
                ),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: AppColors.primary,
              size: 22.h,
            ),
            onPressed: _toggleVisibility,
            splashRadius: 18,
          ),
        ],
      ),
    );

  }

}