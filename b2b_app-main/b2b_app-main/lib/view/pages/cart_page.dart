import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../utils/app_colors.dart';
import '../widgets/bottom_sheet_cart.dart';
import '../widgets/cart_item_container.dart';
import '../widgets/empty_cart.dart';

class CartPage extends StatefulWidget {
  final Function(int)? onNavigateToPage;
  const CartPage({super.key, this.onNavigateToPage});

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  final CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    cartController.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 3.h),
          decoration: BoxDecoration(
            color: cartController.cartItems.isEmpty
                ? AppColors.primaryBackground
                : AppColors.secondBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 16.w, top: 8.h, bottom: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // TextButton(
                    //   onPressed: () {
                    //     showModalBottomSheet<void>(
                    //       context: context,
                    //       elevation: 0,
                    //       builder: (BuildContext context) {
                    //         return BottomSheetCartContent();
                    //       },
                    //     );
                    //   },
                    //   child: Text(
                    //     "Voir Résumé",
                    //     style: TextStyle(
                    //       color: AppColors.primary,
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.w300,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  final cartItems = cartController.cartItems;

                  if (cartItems.isEmpty) {
                    return EmptyCart(
                      onNavigateToPage: widget.onNavigateToPage,
                    );
                  }

                  return Column(
                    children: [
                      BottomSheetCartContent(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            print("product image ${cartItems[index].product.file}");
                            return CartItemContainer(
                              cartItemModel: cartItems[index],
                              onRemove: () async {
                                await cartController.removeItemByProductId(
                                  cartItems[index].product.id,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}