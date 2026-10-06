import 'package:b2b_app/view/widgets/circular_progressindicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/order_controller.dart';
import '../../models/command_line_model.dart';
import '../../utils/app_colors.dart';
import '../widgets/bottom_container_history_command.dart';
import '../widgets/history_item_container.dart';

class CommandDetailPage extends StatefulWidget {
  const CommandDetailPage({super.key});

  @override
  CommandDetailPageState createState() => CommandDetailPageState();
}

class CommandDetailPageState extends State<CommandDetailPage> {
  final OrderController orderController = Get.put(OrderController());
  String? numero;

@override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    numero = ModalRoute.of(context)?.settings.arguments as String?;
    orderController.getOrderDetails(keyword: numero);
  });
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.primaryBackground,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, size: 28.sp, color: AppColors.primary),
      ),
    ),
    backgroundColor: AppColors.secondBackground,
    body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Obx(() {
          if (orderController.isLoading.value) {
            return Center(child: CustomCircularIndicator());
          } else if (orderController.errorMessage.isNotEmpty) {
            return Center(child: Text(orderController.errorMessage.value));
          } else if (orderController.orderDetail.isEmpty) {
            return const Center(child: Text("No orders found."));
          } else {
            
            final order = orderController.orderDetail.first;

            final List<CommandLine> allCommandLines = orderController.orderDetail
                .expand((order) => order.commandLines)
                .toList();

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: allCommandLines.length,
                    itemBuilder: (context, index) {
                      final commandLine = allCommandLines[index];
                      final parentOrder = orderController.orderDetail.firstWhere(
                        (order) => order.commandLines.contains(commandLine),
                      );

                      return HistoryItemContainer(
                        order: parentOrder,
                        commandLine: commandLine,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 3.h),
                  ),
                ),
                BottomContainerHistoryCommand(
                  total_th: order.prixTotalHt,
                  total_ttc: order.prixTotalRemiseTtc,
                ),
              ],
            );
          }
        }),
      ),
    ),
  );
}
}