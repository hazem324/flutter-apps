import 'package:b2b_app/controller/cart_controller.dart';
import 'package:b2b_app/controller/order_controller.dart';
import 'package:b2b_app/utils/app_colors.dart';
import 'package:b2b_app/view/widgets/circular_progressindicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomSheetCartContent extends StatefulWidget {
  const BottomSheetCartContent({super.key});

  @override
  BottomSheetCartContentState createState() => BottomSheetCartContentState();
}

class BottomSheetCartContentState extends State<BottomSheetCartContent> {
  final CartController cartController = Get.put(CartController());
  final OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    cartController.calculTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
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
                Obx(
                  () => Text(
                    "${cartController.totalHt.value.toStringAsFixed(2)} TND",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300,
                      wordSpacing: 2,
                      letterSpacing: 1.2,
                      color: AppColors.primaryBackground,
                    ),
                  ),
                ),
              ],
            ),
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

                Obx(
                  () => Text(
                    "${cartController.totalTtc.value.toStringAsFixed(2)} TND",

                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300,
                      wordSpacing: 2,
                      letterSpacing: 1.2,
                      color: AppColors.primaryBackground,
                    ),
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
                Obx(
                  () => Text(
                    "${cartController.deliveryFee.value.toStringAsFixed(2)} TND",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300,
                      wordSpacing: 2,
                      letterSpacing: 1.2,
                      color: AppColors.primaryBackground,
                    ),
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
                Obx(() {
                  final total =
                      cartController.totalTtc.value +
                      cartController.deliveryFee.value;
                  return Text(
                    "${total.toStringAsFixed(2)} DT",

                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      wordSpacing: 2,
                      letterSpacing: 1.2,
                      color: AppColors.primaryBackground,
                    ),
                  );
                }),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height / 40),
//             GestureDetector(
//   onTap: () async {
//     // Affiche la popup de chargement
//     showDialog(
//       context: context,
//       barrierDismissible: false, // Empêche la fermeture en cliquant en dehors
//       builder: (_) => Dialog(
//         backgroundColor: Colors.transparent,
//         child: Center(child: CustomCircularIndicator()),
//       ),
//     );

//     final command = cartController.toCommandModel();
//     await orderController.placeOrder(command);

//     // Ferme la popup (même si une erreur s'est produite)
//     if (context.mounted) {
//       Navigator.of(context).pop(); // Fermer le dialog
//     }
//   },
//   child: Container(
//     margin: EdgeInsets.all(5).w,
//     padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
//     decoration: BoxDecoration(
//       color: AppColors.primaryBackground,
//       borderRadius: BorderRadius.circular(10.r),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         "Passer commande",
//         style: TextStyle(
//           color: AppColors.primary,
//           fontSize: 15.sp,
//           fontWeight: FontWeight.w500,
//           wordSpacing: 1.2,
//           letterSpacing: 1.1,
//         ),
//       ),
//     ),
//   ),
// ),

OutlinedButton(
  onPressed: () async {
    // Affiche la popup de chargement
    showDialog(
      context: context,
      barrierDismissible: false, // Empêche la fermeture en cliquant en dehors
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Center(child: CustomCircularIndicator()),
      ),
    );

    final command = cartController.toCommandModel();
    await orderController.placeOrder(command);

    // Ferme la popup (même si une erreur s'est produite)
    if (context.mounted) {
      Navigator.of(context).pop(); // Fermer le dialog
    }
  },
  style: OutlinedButton.styleFrom(
    side: BorderSide(color:AppColors.primaryBackground),
    backgroundColor: Colors.transparent,
    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
  ),
  child: Padding(
    padding: EdgeInsets.all(8.0),
    child: Text(
      "Passer commande",
      style: TextStyle(
        color: AppColors.primaryBackground,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        wordSpacing: 1.2,
        letterSpacing: 1.1,
      ),
    ),
  ),
)

          ],
        ),
      ),
    );
  }
}
