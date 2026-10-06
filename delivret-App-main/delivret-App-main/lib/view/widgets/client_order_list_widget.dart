import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:deliveryapp/controller/orders_controller.dart';
import 'package:deliveryapp/model/order_model.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:deliveryapp/view/widgets/slidable_container_widget.dart';
import 'package:deliveryapp/view/widgets/text_field_widget.dart';
import 'package:deliveryapp/view/widgets/text_subtitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../model/address_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/custom_navigation.dart';
import '../../utils/order_status_enum.dart';
import '../screen/order_track_screen.dart';
import 'costom_alert_dialog_widget.dart';

class MyOrderScreen extends StatefulWidget {
  MyOrderScreen({super.key});

  @override
  MyOrderScreenState createState() => MyOrderScreenState();
}

class MyOrderScreenState extends State<MyOrderScreen> {
  bool startAnimation = false;
  OrderController orderController = Get.put(OrderController());

  TextEditingController streetDepart = TextEditingController();
  TextEditingController codeDepart = TextEditingController();
  TextEditingController cityDepart = TextEditingController();
  TextEditingController stateDepart = TextEditingController();

  TextEditingController streetLivraison = TextEditingController();
  TextEditingController codeLivraison = TextEditingController();
  TextEditingController cityLivraison = TextEditingController();
  TextEditingController stateLivraison = TextEditingController();
  final ValueNotifier<String> statusNotifier = ValueNotifier<String>('');
  @override
  void initState() {
    super.initState();
    orderController.getOrderByClient();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
      statusNotifier.addListener(() {
        // When the status changes, send a notification
        if (statusNotifier.value != 'En cours') {
          sendNotification(statusNotifier.value);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Obx(() => orderController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (orderController.orderClientList.isEmpty)
              ? Center(child: SvgPicture.asset('assets/icons/Empty.svg'))
              : RefreshIndicator(
                  onRefresh: () async {
                    await orderController.getOrderByClient();
                    setState(() {});
                  },
                  child: ListView.builder(
                    itemCount: orderController.orderClientList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var orderClientList =
                          orderController.orderClientList[index];
                      var delivery = orderClientList.departureAddress;
                      var livraison = orderClientList.deliveryAddress;
      
                      return GestureDetector(
                        onTap: () => {
                          Navigator.of(context).push(CustomPageTransition(
                              child: OrderStatusScreen(
                                order: orderClientList,
                              ),
                              direction: AxisDirection.right))
                        },
                        child: SlidableContainer(
                          startAnimation: startAnimation,
                          detarturAddress:
                              '${delivery!.street}, ${delivery.city} ${delivery.postalCode}, ${delivery.state}',
                          livraisonAddress:
                              '${livraison!.street}, ${livraison.city} ${livraison.postalCode}, ${livraison.state}',
                          status: Status.orderStatus(orderClientList.status),
                          index: index + 1,
                          onDelete: () async => {
                            print(
                                'orderId is ${orderClientList.id.toString()}'),
                          await  orderController.deleteById(orderClientList.id.toString()),
                            //  orderController.getOrderByUser(),
                            setState(() {}),
                          },
                          onUpdate: () => {
                            print('hello'),
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertDialog(
                                      title: translation(context).change_address,
                                      content: SingleChildScrollView(
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              TextSubTitile(
                                                  subTitle:
                                                      translation(context).departure_address),
                                            ],
                                          ),
                                          MyTextField(
                                            controller: streetDepart,
                                            hintText: "${delivery.street}",
                                            keyboardType: TextInputType.text,
                                            right: 10,
                                            iconColor: AppColors.primary,
                                            icon: const Icon(
                                                Icons.location_on_outlined),
                                          ),
                                          MyTextField(
                                            fixIconBool: false,
                                            controller: stateDepart,
                                            hintText: "${delivery.state}",
                                            keyboardType: TextInputType.text,
                                            right: 10,
                                          ),
                                          MyTextField(
                                            fixIconBool: false,
                                            controller: cityDepart,
                                            hintText: "${delivery.city}",
                                            keyboardType: TextInputType.text,
                                            right: 10,
                                          ),
                                          MyTextField(
                                            fixIconBool: false,
                                            controller: codeDepart,
                                            hintText: "${delivery.postalCode}",
                                            keyboardType: TextInputType.number,
                                            right: 10,
                                          ),
                                          Row(
                                            children: [
                                              TextSubTitile(
                                                  subTitle:translation(context).livraison_address),
                                            ],
                                          ),
                                          //
                                          MyTextField(
                                            controller: streetLivraison,
                                            hintText: "${livraison.street}",
                                            keyboardType: TextInputType.text,
                                            right: 10,
                                            iconColor: AppColors.primary,
                                            icon: const Icon(
                                                Icons.location_on_outlined),
                                          ),
                                          MyTextField(
                                            fixIconBool: false,
                                            controller: stateLivraison,
                                            hintText: "${livraison.state}",
                                            keyboardType: TextInputType.text,
                                            right: 10,
                                          ),
                                          MyTextField(
                                            fixIconBool: false,
                                            controller: cityLivraison,
                                            hintText: "${livraison.city}",
                                            keyboardType: TextInputType.text,
                                            right: 10,
                                          ),
                                          MyTextField(
                                            fixIconBool: false,
                                            controller: codeLivraison,
                                            hintText: "${livraison.postalCode}",
                                            keyboardType: TextInputType.number,
                                            right: 10,
                                          ),
                                        ]),
                                      ),
                                      confirmButtonText: translation(context).change,
                                      onConfirmPressed: () async {
                                        if (int.tryParse(codeDepart.text) ==
                                                null ||
                                            int.tryParse(codeLivraison.text) ==
                                                null) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    AppColors.white,
                                                content: TextSubTitile(
                                                    subTitle: translation(context).please_valid_postal),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text(translation(context).ok),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          return;
                                        }

                                        final orderModel = OrderModel(
                                          departureAddress: AddressModel(
                                            street: (streetDepart.text == "")
                                                ? delivery.street
                                                : streetDepart.text,
                                            city: (cityDepart.text == "")
                                                ? delivery.city
                                                : cityDepart.text,
                                            state: (stateDepart.text == "")
                                                ? delivery.state
                                                : stateDepart.text,
                                            postalCode: (int.tryParse(
                                                        codeDepart.text) ==
                                                    0)
                                                ? delivery.postalCode
                                                : int.tryParse(codeDepart.text),
                                          ),
                                          deliveryAddress: AddressModel(
                                            street: (streetLivraison.text == "")
                                                ? livraison.street
                                                : streetLivraison.text,
                                            city: (cityLivraison.text == "")
                                                ? livraison.city
                                                : cityLivraison.text,
                                            state: (stateLivraison.text == "")
                                                ? livraison.state
                                                : stateLivraison.text,
                                            postalCode: (int.tryParse(
                                                        codeLivraison.text) ==
                                                    0)
                                                ? livraison.postalCode
                                                : int.tryParse(
                                                    codeLivraison.text),
                                          ),
                                          description: '',
                                          status: Status.processing.intValue,
                                          client: User(id: ""),
                                        );
                                        orderController.upDateOrder(
                                            orderModel, orderClientList.id!);
                                        // orderController.getOrderByUser();
                                        setState(() {});
                                        Navigator.of(context).pop();
                                      });
                                }),
                          },
                        ),
                      );
                    },
                  ),
                ));
    
  }

  void sendNotification(String status,) {
    // notification logic to send a notification with the updated status
    String notificationMessage;
    switch (status) {
      case 'En charge':
        notificationMessage = 'Your order is now being processed.';
        break;
      case 'Shipping':
        notificationMessage = 'Your order is now Shipping.';
        break;
      case 'On the Way':
        notificationMessage = 'Your order is now on the way.';
        break;
      case 'Delivered':
        notificationMessage = 'Your order has been delivered.';
        break;
      default:
        notificationMessage = 'Order status updated to $status.';
        break;
    }

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'high_importance_channel',
        title: 'Status Update',
        body: notificationMessage,
      ),
    );
  }
}
