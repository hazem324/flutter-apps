import 'package:b2b_app/utils/const_string.dart';
import 'package:b2b_app/view/widgets/price_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:input_quantity/input_quantity.dart';

import '../../models/cart_item_model.dart';
import '../../utils/app_colors.dart';

class CartItemContainer extends StatelessWidget {
  final CartItemModel cartItemModel;
  final void Function()? onRemove;
  final void Function(int)? onQtyChanged;

  const CartItemContainer({
    super.key,
    required this.cartItemModel,
    this.onRemove,
    this.onQtyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final product = cartItemModel.product;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        children: [
          /// Title & delete button
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
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.trashCan,
                  color: AppColors.second,
                  size: 16.h,
                ),
                onPressed: onRemove,
              ),
            ],
          ),

          /// Image + price + reference
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (product.file == null)
                    ? Image.asset(
                        "assets/images/placeHolder-img.jpg",
                        width: 100.w,
                        height: 90.h,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                          "$BASE_FIlE_URL/${product.file!.url}",
                        width: 100.w,
                        height: 90.h,
                        fit: BoxFit.cover,
                      ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Ref
                        RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: 'Ref : ',
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 16.h,
                              fontWeight: FontWeight.w400,
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
                          Flexible(
                            child: Text(
                              " : ${product.supplierId}.",
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

          /// Colisage & Quantity
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Colisage
              RichText(
                text: TextSpan(
                  text: 'Colisage : ',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16.h,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: '${product.colisage}',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15.h,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              // Quantity input
              InputQty(
                qtyFormProps: QtyFormProps(
                  enableTyping: false,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                decoration: QtyDecorationProps(
                  btnColor: AppColors.primary,
                  isBordered: false,
                  plusBtn: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 2.h,
                      horizontal: 10.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.add,
                      color: AppColors.primaryBackground,
                      size: 18.sp,
                    ),
                  ),
                  minusBtn: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 2.h,
                      horizontal: 10.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.remove,
                      color: AppColors.primaryBackground,
                      size: 18.sp,
                    ),
                  ),
                ),
                maxVal: product.quantity,
                initVal: cartItemModel.quantity,
                minVal: product.colisage,
                steps: product.colisage,
                onQtyChanged: (val) {
                  if (onQtyChanged != null) {
                    onQtyChanged!(val.toInt());
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
