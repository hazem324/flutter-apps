import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';

class PriceRow extends StatelessWidget {
  final double prixTtc;
  final double remisePercentage;

  const PriceRow({
    Key? key,
    required this.prixTtc,
    required this.remisePercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasRemise = remisePercentage > 0;
    final double discountedPrice = prixTtc * (100 - remisePercentage)/100;

    return hasRemise
        ? RichText(
            text: TextSpan(
              text: "${discountedPrice.toStringAsFixed(3)} DT  ",
              style: TextStyle(
                color: AppColors.green,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: "${prixTtc.toStringAsFixed(3)} DT",
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors.secondTextColor,
                    decorationThickness: 2,
                    fontSize: 15.sp,
                    color: AppColors.secondTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        : Text(
            "${prixTtc.toStringAsFixed(3)} DT",
            style: TextStyle(
              color: AppColors.green,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          );
  }
}
