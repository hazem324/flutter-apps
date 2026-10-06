import 'package:b2b_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'product_status_badge.dart';

class ProductContainerHeader extends StatelessWidget {
  final String name;
  final int stock;

  ProductContainerHeader({required this.name, required this.stock});
  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                    wordSpacing: 1.2,
                  ),
                ),
              ),
              ProductStatusBadge(stock: stock),
              
            ],
          );
  }

  
}