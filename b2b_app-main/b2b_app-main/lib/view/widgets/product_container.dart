import 'package:b2b_app/models/product_model.dart';
import 'package:b2b_app/view/widgets/product_container_button.dart';
import 'package:b2b_app/view/widgets/product_container_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import 'product_container_header.dart';
import 'product_container_makes.dart';

class ProductContainer extends StatelessWidget {
  final ProductModel product;
  final void Function(String productId) onDetailTap;
  final void Function({required String productId,required String desig}) onRelatedTap;

  const ProductContainer({
    super.key,
    required this.product,
    required this.onDetailTap,
    required this.onRelatedTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,

        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProductContainerHeader(
            name: product.designation,
            stock: product.quantity,
          ),

          ProductContainerInfo(
            ref: product.id,
            fourniseur: product.supplierId,
            prixTTC: product.prixTtc,
            remise: product.supplier?.remises.isNotEmpty == true
                ? product.supplier!.remises.first.remisePercentage
                : 0,
            url: product.file?.url,
          ),
          product.applications.isNotEmpty
              ? ProductContainerMakes(applications: product.applications)
              : SizedBox.shrink(),
          ProductContainerButton(
            colisage: product.colisage,
            qat: product.quantity,
            product: product,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  onDetailTap(product.id);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.h,
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(12.h)),
                  ),
                  child: Text(
                    "Détails produit",
                    style: TextStyle(
                      color: AppColors.primaryBackground,
                      fontSize: 17,
                      wordSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // equivalence piece
              TextButton(
                onPressed: () {
                  onRelatedTap(productId :product.id, desig:  product.designation);
                },
                child: Text(
                  "Equivalence piéce",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    wordSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
