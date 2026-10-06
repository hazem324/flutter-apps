import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class BuildNavItem extends StatelessWidget{
  

  final IconData iconData;
  final int index;
  final int selectedIndex;

const  BuildNavItem ({super.key, required this.iconData, required this.index, required this.selectedIndex});


  @override
  Widget build(BuildContext context) {
      final bool isSelected = index == selectedIndex;
    return Container(

      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(12.r), 
      ),
      child: Icon(
        iconData,
        size: 22.sp,
        color:  Colors.white ,
      ),
    );
  }
  

  
}