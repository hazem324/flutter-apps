import 'package:b2b_app/utils/const_string.dart';
import 'package:b2b_app/view/widgets/price_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/app_colors.dart';

class ProductContainerInfo extends StatelessWidget {
  final String ref;
  final String fourniseur;
  final double prixTTC;
  final double remise;
  final String? url;
  const ProductContainerInfo({
    super.key,
    required this.ref,
    required this.fourniseur,
    required this.prixTTC,
    required this.remise,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            url == null
                ? Image.asset(
                    "assets/images/placeHolder-img.jpg",
                    width: 80.w,
                    height:70.h,
                    fit: BoxFit.contain,
                  )
                : Image.network(
                    "$BASE_FIlE_URL/$url",
                    width: 80.w,
                    height: 70.h,
                    fit: BoxFit.contain,
                  ),

            SizedBox(width: 10.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: 'Ref : ',
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 16.h,
                          fontWeight: FontWeight.w400,
                          wordSpacing: 1.2.w,
                        ),
                        children: [
                          TextSpan(
                            text: ref,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1.1.w,
                              fontSize: 15.h,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.boxesStacked,
                            color: AppColors.textColor,
                            size: 16.h,
                          ),
                          Flexible(
                            child: Text(
                              " : $fourniseur.",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.1.w,
                                fontSize: 15.h,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PriceRow(prixTtc: prixTTC, remisePercentage: remise),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
