// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import 'text_filed.dart';


class buildLabeledField extends StatelessWidget{
    String label;
    IconData icon;
    TextEditingController controller;

  buildLabeledField({super.key,  required this.label, required this.controller, required this.icon});

    

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5.h, left: 8.w),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
              letterSpacing: 1.2,
            ),
          ),
        ),

        CustomTextFiled(
          height: 40.h,
          readOnly: true,
          icon: icon,
          hintText: label,
          controller: controller,
        ),
      ],
    );
  }
  
}
