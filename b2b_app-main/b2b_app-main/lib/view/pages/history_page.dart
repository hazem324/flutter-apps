import 'package:b2b_app/view/widgets/circular_progressindicator.dart';
import 'package:b2b_app/view/widgets/custom_date_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/order_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/data.dart';
import '../../utils/page_routes.dart';
import '../widgets/order_tile.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  int currentPage = 1;
  DateTime? selectedDate;
  DateTime? selectedEndDate;
  String? selectedValue;
  final ScrollController scrollController = ScrollController();
  final OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    fetchOrders();
    scrollController.addListener(loadMoreOrders);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void fetchOrders() {
    orderController.getAllOrder(
      page: currentPage,
      pageSize: 10,
      startDate: selectedDate,
      endDate: selectedEndDate,
      status: selectedValue,
    );
  }

  void loadMoreOrders() async {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !orderController.isLoading.value &&
        orderController.hasNext.value) {
      currentPage++;
      orderController.getAllOrder(
        page: currentPage,
        pageSize: 10,
        startDate: selectedDate,
        endDate: selectedEndDate,
        status: selectedValue,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondBackground,
      body: Column(
        children: [
          SizedBox(height: 15.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter Commands',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      onPressed:
                          (selectedDate != null ||
                              selectedEndDate != null ||
                              selectedValue != null)
                          ? () {
                              setState(() {
                                selectedDate = null;
                                selectedEndDate = null;
                                selectedValue = null;
                                currentPage = 1;
                              });
                              fetchOrders();
                            }
                          : null,
                      icon: Icon(
                        (selectedDate != null ||
                                selectedEndDate != null ||
                                selectedValue != null)
                            ? Icons.filter_alt_off
                            : Icons.filter_alt,
                        color: AppColors.primary,
                        size: 24.sp,
                      ),
                      tooltip:
                          (selectedDate != null ||
                              selectedEndDate != null ||
                              selectedValue != null)
                          ? 'Clear Filters'
                          : 'Filter',
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomDatePicker(
                        label: 'Select Date',
                        selectedDate: selectedDate,
                        maxDate: selectedEndDate ?? DateTime.now(),
                        onDateSelected: (date) {
                          setState(() {
                            selectedDate = date;
                            currentPage = 1;
                            if (selectedEndDate != null &&
                                date != null &&
                                date.isAfter(selectedEndDate!)) {
                              selectedEndDate = null;
                            }
                          });
                          fetchOrders();
                        },
                      ),
                      SizedBox(width: 10.w),
                      CustomDatePicker(
                        label: 'Date fin',
                        selectedDate: selectedEndDate,
                        minDate: selectedDate,
                        maxDate: DateTime(DateTime.now().year + 5),
                        onDateSelected: (date) {
                          setState(() {
                            selectedEndDate = date;
                            currentPage = 1;
                          });
                          fetchOrders();
                        },
                      ),
                      SizedBox(width: 10.w),
                      // Ton dropdown status ici
                      SizedBox(
                        width: 200.w,
                        child: DropdownButtonFormField2<String>(
                          value: selectedValue,
                          isExpanded: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 14.h,
                              horizontal: 12.w,
                            ),
                            filled: true,
                            fillColor: AppColors.primaryBackground,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 2,
                              ),
                            ),
                          ),
                          hint: Text(
                            'Sélectionné status',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.lightGreyTextColor,
                            ),
                          ),
                          items: statusItems
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                              currentPage = 1;
                            });
                            fetchOrders();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Order list
          Expanded(
            child: Obx(() {
              if (orderController.isLoading.value &&
                  orderController.orderHistory.isEmpty) {
                return  Center(child: CustomCircularIndicator());
              }

              if (orderController.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Text(
                    orderController.errorMessage.value,
                    style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              final orders = orderController.orderHistory;

              return ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5.h),
                itemCount:
                    orders.length + (orderController.isLoading.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == orders.length) {
                    return  Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Center(child: CustomCircularIndicator()),
                    );
                  }

                  final commande = orders[index];
                  return OrderTile(
                    commande: {
                      'num': commande.numero,
                      'date':
                          '${commande.createdAt.day}/${commande.createdAt.month}/${commande.createdAt.year}',
                      'total': '${commande.prixTotalTtc} TND',
                      'status': commande.status,
                    },
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        commandDetailPage,
                        arguments: commande.numero,
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
