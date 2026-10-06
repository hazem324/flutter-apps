import 'package:b2b_app/models/cart_item_model.dart';
import 'package:b2b_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';

import '../../controller/cart_controller.dart';
import '../../models/product_model.dart';

class ProductContainerButton extends StatefulWidget {
  @override
  ProductContainerButtonState createState() => ProductContainerButtonState();

  final int colisage;
  final int qat;

  final ProductModel product;
  const ProductContainerButton({
    required this.colisage,
    required this.qat,
    required this.product,
    super.key,
  });
}

class ProductContainerButtonState extends State<ProductContainerButton> {
  final cartController = Get.find<CartController>();
   late int selectedQuantity;


   @override
  void initState() {
    super.initState();
    selectedQuantity = widget.qat == 0 ? 0 : widget.colisage;
  }
  @override
  Widget build(BuildContext context) {
    
    final bool isOutOfStock = widget.qat == 0;
    return Row(
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
                text: '${widget.colisage}',
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
        Row(
          children: [
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
    btnColor: isOutOfStock ? Colors.grey : AppColors.primary,
    isBordered: false,
    plusBtn: Container(
      padding: EdgeInsets.symmetric(
        vertical: 2.h,
        horizontal: 10.w,
      ),
      decoration: BoxDecoration(
        color: isOutOfStock ? Colors.grey : AppColors.primary,
        borderRadius: BorderRadius.circular(20.r),
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
        color: isOutOfStock ? Colors.grey : AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        Icons.remove,
        color: AppColors.primaryBackground,
        size: 18.sp,
      ),
    ),
  ),
  maxVal: isOutOfStock ? 0 : widget.qat,
  minVal: 0,
  initVal: isOutOfStock ? 0 : widget.colisage,
  steps: isOutOfStock ? 0 : widget.colisage,
  onQtyChanged: (val) {
    if (!isOutOfStock) {
      setState(() {
        selectedQuantity = val.toInt();
      });
      print("Selected Quantity: $selectedQuantity");
    }
  },
),

Padding(
  padding: EdgeInsets.symmetric(horizontal: 10.w),
  child: GestureDetector(
    onTap: isOutOfStock
        ? null
        : () async{
           await cartController.addItem(
              CartItemModel(
                quantity: selectedQuantity,
                product: widget.product,
              ),
            );
           
          },
    child: Icon(
      FontAwesomeIcons.cartShopping,
      color: isOutOfStock ? Colors.grey : AppColors.primary,
      size: 20.h,
    ),
  ),
),
          ],
        ),
      ],
    );
  }
}
