import 'package:b2b_app/view/widgets/price_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/command_line_model.dart';
import '../../models/order_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/const_string.dart';

class HistoryItemContainer extends StatelessWidget {
  final OrderModel order;
  final CommandLine commandLine;
  const HistoryItemContainer({
    super.key,
    required this.commandLine,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final product = commandLine.product;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 7.w),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,

        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  product.designation,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                    wordSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),

          Container(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (product.file == null)
                      ? Image.asset(
                          "assets/images/placeHolder-img.jpg",
                          width: 110.w,
                          height: 100.h,
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          "$BASE_FIlE_URL/${product.file!.url}",
                          width: 110.w,
                          height: 100.h,
                          fit: BoxFit.fill,
                        ),

                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                                  text: product.id,
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
                                Text(
                                  " : Fourniseur",
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
                          PriceRow(
                            prixTtc: product.prixTtc,
                            remisePercentage:
                                product.supplier?.remises.isNotEmpty == true
                                ? product.supplier!  .remises .first.remisePercentage
                                : 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: 'Colisage : ',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16.h,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 1.1.w,
                  ),
                  children: [
                    TextSpan(
                      text:product.colisage.toString(),
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

              RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: 'Quantity : ',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16.h,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 1.1.w,
                  ),
                  children: [
                    TextSpan(
                      text: commandLine.confirmedQuantity.toString(),
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
            ],
          ),
        ],
      ),
    );
  }
}
