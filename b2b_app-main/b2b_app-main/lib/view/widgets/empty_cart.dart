import 'package:b2b_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class EmptyCart extends StatelessWidget {
  final Function(int)? onNavigateToPage;

  const EmptyCart({super.key, required this.onNavigateToPage});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/empty-cart.svg",
            height: MediaQuery.of(context).size.height / 2.2,
            width: MediaQuery.of(context).size.width / 1.8,
          ),
          Text(
            "Votre panier est vide",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 60),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(
              "Il semble que vous n'ayez encore rien ajouté à votre panier.",
              textAlign: TextAlign.center,
              style: TextStyle(
                wordSpacing: 1.2,
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
                color: AppColors.secondTextColor,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 35),
          OutlinedButton(
            onPressed: () async {
              if (onNavigateToPage == null) {
              } else {
                onNavigateToPage?.call(1);
              }
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              side: BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              backgroundColor: AppColors.primaryBackground,
            ),
            child: Text(
              "Voir le catalogue",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
