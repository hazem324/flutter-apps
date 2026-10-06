import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class ProductStatusBadge extends StatelessWidget {
  final int stock;

  const ProductStatusBadge({
    super.key,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    String label;

    if (stock == 0) {
      bgColor = AppColors.second;
      label = "Non Disponible";
    } else {
      bgColor = AppColors.green;
      label = "Disponible";
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: AppColors.primaryBackground,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
