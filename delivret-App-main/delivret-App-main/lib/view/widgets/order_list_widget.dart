// ignore_for_file: use_build_context_synchronously

import 'package:deliveryapp/controller/orders_controller.dart';
import 'package:deliveryapp/controller/user_controller.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/custom_navigation.dart';
import '../screen/order_info_screen.dart';
import 'custom_tost_widget.dart';
import 'order_container_info_widget.dart';

class OrderListWidget extends StatefulWidget {
  @override
  OrderListWidgetState createState() => OrderListWidgetState();
}

class OrderListWidgetState extends State<OrderListWidget> {
  OrderController orderController = Get.put(OrderController());
  UserController userController = Get.put(UserController());
  final tost = FToast();

  @override
  void initState() {
    super.initState();
    orderController.getAllOrder();
    userController.getUser();
    tost.init(context);
  }
  ///////order model 

  @override
  Widget build(BuildContext context) {
    
    return Obx(() => RefreshIndicator(
          onRefresh: () async {
            await orderController.getAllOrder();
            setState(() {});
          },
          child: (orderController.allOrderList.isEmpty)
              ? Center(child: SvgPicture.asset('assets/icons/Empty.svg'))
              : ListView.builder(
                
                  itemCount: orderController.allOrderList.length,
                  itemBuilder: (context, int index) {
                    var allOrder = orderController.allOrderList[index];
                    return GestureDetector(
                      onTap: () => {
                        Navigator.of(context).push(CustomPageTransition(
                          child: OrderInfoScreen(
                             order: allOrder,
                          ),
                          direction: AxisDirection.up,
                        )),
                      },
                      child: OrderContainer(
                        order: allOrder,
                          index: index + 1,
                          takeInCharge: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String livreurId =
                                prefs.getString("clientId") ?? "";
                            int? statusCode = await orderController
                                .takeEnCharge(livreurId, allOrder.id ?? "");
                            if (statusCode == 200) {
                              tost.showToast(
                                  child: CustomTostWidget( text: translation(context).is_processing),
                                  gravity: ToastGravity.BOTTOM);
                            } else {
                              tost.showToast(
                                  child: CustomTostWidget(text: translation(context).failled),
                                  gravity: ToastGravity.BOTTOM);
                            }
                            orderController.orderList();
                            setState(() {});
                          },),
                    );
                  }),
        ));
  }
}
