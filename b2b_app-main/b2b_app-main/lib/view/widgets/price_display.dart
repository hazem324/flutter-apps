import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductPriceDisplay extends StatelessWidget {
  final double prixTtc;
  final double remisePercentage;

  const ProductPriceDisplay({
    super.key,
    required this.prixTtc,
    required this.remisePercentage,
  });

  @override
  Widget build(BuildContext context) {
    final hasRemise = remisePercentage > 0;
    final prixRemise = prixTtc * (1 - remisePercentage / 100);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: hasRemise
              ? RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${prixRemise.toStringAsFixed(3)} DT ',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'au lieu de ',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                        text: '${prixTtc.toStringAsFixed(3)} DT',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.grey,
                          decorationThickness: 2,
                          fontSize: 16.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : Text(
                  '${prixTtc.toStringAsFixed(3)} DT',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        SizedBox(width: 8.w),
        if (hasRemise)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '-${remisePercentage.toStringAsFixed(0)}%',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
