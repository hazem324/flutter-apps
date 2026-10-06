import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class BottomContainerHistoryCommand  extends StatelessWidget{
  final double total_th;
  final double total_ttc;
  
  const BottomContainerHistoryCommand({super.key, required this.total_th, required this.total_ttc,});

  @override
  Widget build(BuildContext context) {
    final double  total = total_ttc + 9.0;
   return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total HT  : ",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 2,
                    letterSpacing: 1.2,
                    color: AppColors.primaryBackground,
                  ),
                ),
                Text(
                  "${total_th.toStringAsFixed(3)} TND",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                    wordSpacing: 2,
                    letterSpacing: 1.2,
                    color: AppColors.primaryBackground,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 150),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total TTC : ",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 2,
                    letterSpacing: 1.2,
                    color: AppColors.primaryBackground,
                  ),
                ),
                Text(
                  "${total_ttc.toStringAsFixed(3)} TND",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                    wordSpacing: 2,
                    letterSpacing: 1.2,
                    color: AppColors.primaryBackground,
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height / 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Frais de livraison : ",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 2,
                    letterSpacing: 1.2,
                    color: AppColors.primaryBackground,
                  ),
                ),
                Text(
                  "9,000 TND",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                    wordSpacing: 2,
                    letterSpacing: 1.2,
                    color: AppColors.primaryBackground,
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 25,
                top: 4.h,
                bottom: 10.h,
              ),
              child: Divider(
                thickness: 1.5,
                color: AppColors.primaryBackground,
                // endIndent: MediaQuery.of(context).size.width/25,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total prix : ",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    wordSpacing: 2,
                    letterSpacing: 1.2,
                    color: AppColors.primaryBackground,
                  ),
                ),
                Text(
                  "${total.toStringAsFixed(3)} DT",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 2,
                    letterSpacing: 1.2,
                    color: AppColors.primaryBackground,
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height / 85),
          ],
        ),
      ),
    );
  }



  
}